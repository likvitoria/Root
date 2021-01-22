--------------------------------------------------
--		Partial full adder		--
--------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Partial_Full_Adder is
Port ( 
	A : in STD_LOGIC;
	B : in STD_LOGIC;
	S : out std_logic;
	Cout : out std_logic
);
end Partial_Full_Adder;
 
architecture Behavioral of Partial_Full_Adder is
 
begin
 
S <= A xor B;
Cout <= A and B;
 
end Behavioral;