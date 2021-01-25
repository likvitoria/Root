
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package mix_package is

component carry_inc_mix is
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

end mix_package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.incrementer_package.all;
use work.carry_inc_package.all;


entity carry_inc_mix is
	generic(
		DATA_WIDTH    : INTEGER := 17;
	   	ADDER_1_WIDTH : INTEGER := 8;
		ADDER_2_WIDTH : INTEGER := 9
	);
	port (  
		input0    : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		input1    : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		carry_in  : in std_logic;
		result    : out std_logic_vector(DATA_WIDTH - 1 downto 0);	
		carry_out : out std_logic
    );
end carry_inc_mix;

architecture Behavioral of carry_inc_mix is

	signal carry_out_1, carry_out_2 : std_logic;
	
	signal result_temp : std_logic_vector(ADDER_2_WIDTH - 1 downto 0);

begin

	CARRY_INC_0 : carry_inc_adder
	generic map(
		DATA_WIDTH    => 8,
	   	ADDER_1_WIDTH => 4,
		ADDER_2_WIDTH => 4
	)
	port map(  
		input0    => input0(ADDER_1_WIDTH-1 downto 0),
		input1    => input1(ADDER_1_WIDTH-1 downto 0),
		carry_in  => carry_in,
		result    => result(ADDER_1_WIDTH-1 downto 0),
		carry_out => carry_out_1
   );
	
	CARRY_INC_1 : carry_inc_adder
	generic map(
		DATA_WIDTH    => 9,
	   	ADDER_1_WIDTH => 4,
		ADDER_2_WIDTH => 5
	)
	port map(  
		input0    => input0(DATA_WIDTH-1 downto ADDER_1_WIDTH),
		input1    => input1(DATA_WIDTH-1 downto ADDER_1_WIDTH),
		carry_in  => '0',
		result    => result_temp,
		carry_out => carry_out_2
   );
	
	INCREMENTER_0 : incrementer
	generic map(
		WIDTH => ADDER_2_WIDTH
	)
	port map (
		carry_in_1  => carry_out_1,
		carry_in_2  => carry_out_2,
		bits_in     => result_temp,
		bits_out    => result(DATA_WIDTH-1 downto ADDER_1_WIDTH),
		carry_out   => carry_out
	);

end Behavioral;

