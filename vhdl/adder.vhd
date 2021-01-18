--------------------------------------------------------------------------
							--  Ripple Carry -- 
--------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;

package Adder_package is

component Adder is 
	generic(ADDER_WIDTH : INTEGER := 17);
	port (  
		input0    : in std_logic_vector(ADDER_WIDTH - 1 downto 0);
		input1    : in std_logic_vector(ADDER_WIDTH - 1 downto 0);
		carry_in  : in std_logic;
		result    : out std_logic_vector(ADDER_WIDTH - 1 downto 0);	
		carry_out : out std_logic
        );
end component;

end Adder_package;

library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.Add1Rip_package.all;
	use work.adder_package.all;

entity Adder is 
	generic(ADDER_WIDTH : INTEGER := 17);
	port (
		input0    : in std_logic_vector(ADDER_WIDTH - 1 downto 0);
		input1    : in std_logic_vector(ADDER_WIDTH - 1 downto 0);
		carry_in  : in std_logic;
		result    : out std_logic_vector(ADDER_WIDTH - 1 downto 0);
		carry_out : out std_logic
        );
end Adder;



architecture dataflow of Adder is

	signal sig_carry_in	:   std_logic_vector(ADDER_WIDTH downto 0);

begin

	sig_carry_in(0) <= carry_in;

	adder : for bit_number in 0 to ADDER_WIDTH - 1 generate
		bit_adder : Add1Rip
			port map (
				input0    => input0(bit_number),
				input1    => input1(bit_number),
				carry_in  => sig_carry_in(bit_number),
				result    => result(bit_number),
				carry_out => sig_carry_in(bit_number + 1)
			);
	end generate;

	carry_out <= sig_carry_in(ADDER_WIDTH);

end dataflow;