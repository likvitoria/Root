
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package incrementer_package is

component incrementer is
   generic(WIDTH : INTEGER := 4);
	port (  
		carry_in_1  : in std_logic;
		carry_in_2  : in std_logic;
		bits_in     : in std_logic_vector(WIDTH-1 downto 0);
		bits_out    : out std_logic_vector(WIDTH-1 downto 0);
		carry_out   : out std_logic
    );
end component;

end incrementer_package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity incrementer is
   generic(
	   WIDTH: INTEGER := 4
	);
	port (  
		carry_in_1  : in std_logic;
		carry_in_2  : in std_logic;
		bits_in     : in std_logic_vector(WIDTH-1 downto 0);
		bits_out    : out std_logic_vector(WIDTH-1 downto 0);
		carry_out   : out std_logic
    );
end incrementer;



architecture structural of incrementer is

	signal sig : std_logic_vector(WIDTH downto 0);
	
begin

	-- BIT 0
	bits_out(0) <= carry_in_1 xor bits_in(0);
	
	-- BIT 1
	
	sig(0) <= carry_in_1 and bits_in(0);
	bits_out(1) <= sig(0) xor bits_in(1);
	
	PROPAGATE_CARRY: for bit_number in 1 to WIDTH - 2 generate
	
		sig(bit_number) <= sig(bit_number-1) and bits_in(bit_number);
		bits_out(bit_number+1) <= sig(bit_number) xor bits_in(bit_number+1);
	
	end generate;
	
	-- Carry Out
	
	sig(WIDTH - 1) <= sig(WIDTH - 2) and bits_in(WIDTH - 1);
	carry_out <= sig(WIDTH-1) xor carry_in_2;


end structural;

