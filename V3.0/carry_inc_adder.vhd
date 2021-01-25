library ieee;
use ieee.std_logic_1164.all;

package carry_inc_package is

component carry_inc_adder is
	generic(
		DATA_WIDTH    : INTEGER := 9;
	   	ADDER_1_WIDTH : INTEGER := 4;
		ADDER_2_WIDTH : INTEGER := 5
	);
	port (  
		input0    : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		input1    : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		carry_in  : in std_logic;
		result    : out std_logic_vector(DATA_WIDTH - 1 downto 0);	
		carry_out : out std_logic
    );
end component;

end carry_inc_package;


-- LIBRARIES

library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Add1Rip_package.all;
use work.incrementer_package.all;

entity carry_inc_adder is
	generic(
		DATA_WIDTH   : INTEGER := 9;
	   	ADDER_1_WIDTH : INTEGER := 4;
		ADDER_2_WIDTH : INTEGER := 5
	);
	port (  
		input0    : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		input1    : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		carry_in  : in std_logic;
		result    : out std_logic_vector(DATA_WIDTH - 1 downto 0);	
		carry_out : out std_logic
    );
end carry_inc_adder;

architecture Behavioral of carry_inc_adder is

   signal sig_carry_in_1	:   std_logic_vector(ADDER_1_WIDTH downto 0);
	signal sig_carry_in_2	:   std_logic_vector(ADDER_2_WIDTH downto 0);
	signal result_temp	   :   std_logic_vector(ADDER_2_WIDTH -1 downto 0);

begin

	sig_carry_in_1(0) <= carry_in;
	sig_carry_in_2(0) <= '0';

	ADDER_1 : for bit_number in 0 to ADDER_1_WIDTH - 1 generate
		bit_adder_1 : Add1Rip
			port map (
				input0    => input0(bit_number),
				input1    => input1(bit_number),
				carry_in  => sig_carry_in_1(bit_number),
				result    => result(bit_number),
				carry_out => sig_carry_in_1(bit_number + 1)
			);
	end generate;
	
	ADDER_2 : for bit_number in 0 to ADDER_2_WIDTH - 1 generate
		bit_adder_2 : Add1Rip
			port map (
				input0    => input0(bit_number + ADDER_1_WIDTH),
				input1    => input1(bit_number + ADDER_1_WIDTH),
				carry_in  => sig_carry_in_2(bit_number),
				result    => result_temp(bit_number),
				carry_out => sig_carry_in_2(bit_number + 1)
			);
	end generate;
	
	INCREMENTER_0 : incrementer
			generic map(
			   WIDTH => ADDER_2_WIDTH
			)
	  		port map (
				carry_in_1  => sig_carry_in_1(ADDER_1_WIDTH),
				carry_in_2  => sig_carry_in_2(ADDER_2_WIDTH),
				bits_in     => result_temp,
				bits_out    => result(DATA_WIDTH-1 downto ADDER_1_WIDTH),
				carry_out   => carry_out
			);

end Behavioral;

