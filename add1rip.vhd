--------------------------------------------------------------------------
							-- Adder 1 bit--
--------------------------------------------------------------------------


library ieee;
	use ieee.std_logic_1164.all;

package Add1Rip_package is

component Add1Rip is 
	port (	
		input0    : in std_logic;
		input1    : in std_logic;
		carry_in  : in std_logic;
		result    : out std_logic;
		carry_out : out std_logic
		);
end component;

end Add1Rip_package;

library ieee;
	use ieee.std_logic_1164.all;	
library work;
	use work.Add1Rip_package.all;

entity Add1Rip is 
	port (	
		input0    : in std_logic;
		input1    : in std_logic;
		carry_in  : in std_logic;
		result    : out std_logic;
		carry_out : out std_logic
		);
end Add1Rip;


architecture dataflow of Add1Rip is

begin

	result  <= input0 xor input1 xor carry_in;
	carry_out <= (input0 and carry_in) or (input1 and carry_in) or (input0 and input1);

end dataflow;
