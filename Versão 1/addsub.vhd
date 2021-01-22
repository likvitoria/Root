--------------------------------------------------------------------------
--  							Add sub									--
--------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;

package AddSub_package is

component AddSub is 
	generic(ADDSUB_WIDTH : INTEGER := 17);
	port ( 	
    		input0    : in std_logic_vector(ADDSUB_WIDTH - 1 downto 0);
			input1    : in std_logic_vector(ADDSUB_WIDTH - 1 downto 0);
			carry_in  : in std_logic;
			ctrl      : in std_logic;
			result    : out std_logic_vector(ADDSUB_WIDTH - 1 downto 0);
			carry_out : out std_logic
		);
end component;

end AddSub_package;

library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.Add1Rip_package.all;
	use work.AddSub_package.all;

entity AddSub is 
	generic(ADDSUB_WIDTH : INTEGER := 17);
	port (  
		input0    : in std_logic_vector(ADDSUB_WIDTH - 1 downto 0);
		input1    : in std_logic_vector(ADDSUB_WIDTH - 1 downto 0);
		carry_in  : in std_logic;
		ctrl      : in std_logic; -- 0 = adder, 1 = subtractor
		result    : out std_logic_vector(ADDSUB_WIDTH - 1 downto 0);
		carry_out : out std_logic
        );
end AddSub;


architecture dataflow of AddSub is

	signal sig_input1	: std_logic_vector(ADDSUB_WIDTH - 1 downto 0);
	signal sig_carry_in	: std_logic_vector(ADDSUB_WIDTH downto 0);

begin

	sub_cond : for bit_number0 in 0 to ADDSUB_WIDTH - 1 generate
	    sig_input1(bit_number0) <= input1(bit_number0) xor ctrl;
	end generate;

	-- consider the carry_in signal in add and sub operations
	sig_carry_in(0) <= ctrl xor carry_in;

	adder : for bit_number1 in 0 to ADDSUB_WIDTH - 1 generate
		bit_adder : Add1Rip
			port map (	
				input0    => input0(bit_number1),
				input1    => sig_input1(bit_number1),
				carry_in  => sig_carry_in(bit_number1),
				result    => result(bit_number1),
				carry_out => sig_carry_in(bit_number1 + 1)
			);
	end generate;

	-- indicate sum overflow or negative result
	carry_out <= ctrl xor sig_carry_in(ADDSUB_WIDTH);

end dataflow;