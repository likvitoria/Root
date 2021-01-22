
---------------------------------------------------------------
--			Ripple carry adder 		     --
---------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package ripplecarry_package is 

component adder is
	generic(ADDER_WIDTH : INTEGER := 17);
	Port ( 
		A 	: in STD_LOGIC_VECTOR (ADDER_WIDTH - 1 downto 0);
		B 	: in STD_LOGIC_VECTOR (ADDER_WIDTH - 1 downto 0);
		Cin 	: in STD_LOGIC;
		S 	: out STD_LOGIC_VECTOR (ADDER_WIDTH - 1 downto 0);
		Cout 	: out STD_LOGIC
	);
end component;

end ripplecarry_package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Carry_Look_Ahead is
	generic(ADDER_WIDTH : INTEGER := 17);
Port ( 
	A 	: in STD_LOGIC_VECTOR (ADDER_WIDTH - 1 downto 0);
	B 	: in STD_LOGIC_VECTOR (ADDER_WIDTH - 1 downto 0);
	Cin 	: in STD_LOGIC;
	S 	: out STD_LOGIC_VECTOR (ADDER_WIDTH - 1 downto 0);
	Cout 	: out STD_LOGIC);
end Carry_Look_Ahead;
 
architecture Behavioral of Carry_Look_Ahead is
 
component Partial_Full_Adder
Port ( 
	A   : in STD_LOGIC;
	B   : in STD_LOGIC;
	S   : out STD_LOGIC;
	Cout: out std_logic
);
end component;
 
signal c1,c2,c3,c4,c5,c6,c7: STD_LOGIC;
signal c8,c9,c10,c11,c12,c13,c14: STD_LOGIC;
signal c15, c16 : std_logic;
signal p,g: STD_LOGIC_VECTOR(ADDER_WIDTH - 1 downto 0);
signal p1, p2, p3, p4: STD_LOGIC;

begin
 
PFA0: Partial_Full_Adder port map( A(0), B(0), p(0), g(0));
PFA1: Partial_Full_Adder port map( A(1), B(1), p(1), g(1));
PFA2: Partial_Full_Adder port map( A(2), B(2), p(2), g(2));
PFA3: Partial_Full_Adder port map( A(3), B(3), p(3), g(3));

PFA4: Partial_Full_Adder port map( A(4), B(4), p(4), g(4));
PFA5: Partial_Full_Adder port map( A(5), B(5), p(5), g(5));
PFA6: Partial_Full_Adder port map( A(6), B(6), p(6), g(6));
PFA7: Partial_Full_Adder port map( A(7), B(7), p(7), g(7));


PFA8: Partial_Full_Adder port map( A(8), B(8), p(8), g(8));
PFA9: Partial_Full_Adder port map( A(9), B(9), p(9), g(9));
PFA10: Partial_Full_Adder port map( A(10), B(10), p(10), g(10));
PFA11: Partial_Full_Adder port map( A(11), B(11), p(11), g(11));
PFA12: Partial_Full_Adder port map( A(12), B(12), p(12), g(12));

PFA13: Partial_Full_Adder port map( A(13), B(13), p(13), g(13));
PFA14: Partial_Full_Adder port map( A(14), B(14), p(14), g(14));
PFA15: Partial_Full_Adder port map( A(15), B(15), p(15), g(15));
PFA16: Partial_Full_Adder port map( A(16), B(16), p(16), g(16));

p1 <= (p(1) and p(2)) and (p(3) and p(4));
p2 <= (p(5) and p(6)) and (p(7) and p(8));
p3 <= (p(9) and p(10)) and (p(11) and p(12));
p4 <= (p(13) and p(14)) and (p(15) and p(16));
 
c1 <= g(0) OR (p(0) AND Cin);
c2 <= g(1) OR (p(1) AND g(0)) OR (p(1) AND p(0) AND Cin);
c3 <= g(2) OR (p(2) AND g(1)) OR (p(2) AND p(1) AND g(0)) OR (p(2) AND p(1) AND p(0) AND Cin);

c4 <= g(3) or (p(3) and g(2)) or ((p(3) and p(2)) and g(1)) or ((p(3) and p(2)) and (p(1) and g(0))) or 
((p(3) and p(2)) and (p(1) and p(0)) and Cin);

c5 <= g(4) or (p(4) and g(3)) or (p(4) and p(3) and g(2)) or ((p(4) and p(3)) and (p(2) and g(1))) or 
(p1 and g(0)) or (p1 and p(0) and Cin);

c6 <= g(5) or (p(5) and g(4)) or (p(5) and p(4) and g(3)) or ((p(5) and p(4)) and (p(3) and g(2))) or 
((p(5) and p(4)) and (p(3) and p(2)) and g(1)) or ((p(5) and p1) and g(0)) or 
((p(5) and p1) and (p(0) and Cin));

c7 <= g(6) or (p(6) and g(5)) or (p(6) and p(5) and g(4)) or ((p(6) and p(5)) and (p(4) and g(3))) or 
((p(6) and p(5)) and (p(4) and p(3)) and g(2)) or ((p(6) and p(5)) and (p(4) and p(3)) and (p(2) and g(1))) or 
((p(6) and p(5)) and p1 and g(0)) or ((p(6) and p(5)) and (p1 and p(0)) and Cin);

c8 <= g(7) or (p(7) and g(6)) or (p(7) and p(6) and g(5)) or ((p(7) and p(6)) and (p(5) and g(4))) or 
((p(7) and p(6)) and (p(5) and p(4)) and g(3)) or ((p(7) and p(6)) and (p(5) and p(4)) and (p(3) and g(2))) or 
((p(7) and p(6)) and (p(5) and p(4)) and (p(3) and p(2)) and g(1)) or ((p(7) and p(6)) and (p(5) and p1 and g(0))) or 
((p(7) and p(6)) and (p(5) and p1 and p(0)) and Cin);

c9 <= g(8) or (p(8) and g(7)) or (p(8) and p(7) and g(6)) or ((p(8) and p(7)) and (p(6) and g(5))) or 
(p2 and g(4)) or ((p2 and p(4)) and g(3)) or 
((p2 and p(4)) and (p(3) and g(2))) or ((p2 and p(4)) and (p(3) and p(2)) and g(1)) or 
(p2 and p1 and g(0)) or ((p2 and p1) and (p(0) and Cin));

c10 <= g(9) or (p(9) and g(8)) or (p(9) and p(8) and g(7)) or ((p(9) and p(8)) and (p(7) and g(6))) or 
((p(9) and p(8)) and (p(7) and p(6)) and g(5)) or ((p(9) and p2 and g(4))) or 
((p(9) and p2 and p(4)) and g(3)) or ((p(9) and p2 and p(4)) and (p(3) and g(2))) or 
((p(9) and p2 and p(4)) and (p(3) and p(2)) and g(1)) or ((p(9) and p2) and p1 and g(0)) or  
((p(9) and p2) and (p1 and p(0)) and Cin);

c11 <= g(10) or (p(10) and g(9)) or (p(10) and p(9) and g(8)) or ((p(10) and p(9)) and (p(8) and g(7))) or 
((p(10) and p(9)) and (p(8) and p(7)) and g(6)) or 
((p(10) and p(9)) and (p(8) and p(7)) and (p(6) and g(5))) or ((p(10) and p(9)) and p2 and g(4)) or 
((p(10) and p(9)) and p2 and (p(4) and g(3))) or ((p(10) and p(9)) and p2 and (p(4) and p(3)) and g(2)) or 
((p(10) and p(9)) and p2 and (p(4) and p(3)) and (p(2) and g(1))) or ((p(10) and p(9)) and (p2 and p1) and g(0)) or 
((p(10) and p(9)) and (p2 and p1) and (p(0) and Cin));                                                         

c12 <= g(11) or (p(11) and g(10)) or (p(11) and p(10) and g(9)) or ((p(11) and p(10)) and (p(9) and g(8))) or 
((p(11) and p(10)) and (p(9) and p(8)) and g(7)) or 
((p(11) and p(10)) and (p(9) and p(8))and (p(7) and g(6))) or 
((p(11) and p(10)) and (p(9) and p(8))and (p(7)and p(6)) and g(5)) or 
((p(11) and p(10)) and (p(9) and p2 and g(4))) or ((p(11) and p(10)) and (p(9) and p2 and p(4)) and g(3)) or 
((p(11) and p(10)) and (p(9) and p2 and p(4)) and (p(3) and g(2))) or 
((p(11) and p(10)) and (p(9) and p2 and p(4)) and (p(3) and p(2)) and g(1)) or 
((p(11) and p(10)) and (p(9) and p2) and (p1 and g(0))) or ((p(11) and p(10)) and (p(9) and p2 and p1) and p(0) and Cin); 

c13 <= g(12) or (p(12) and g(11)) or (p(12) and p(11) and g(10)) or ((p(12) and p(11)) and (p(10) and g(9))) or 
(p3 and g(8)) or
((p3 and p(8) and g(7))) or ((p3 and p(8)and p(7)) and g(6)) or ((p3 and p(8)and p(7))and (p(6)and g(5))) or 
(p3 and p2 and g(4)) or ((p3 and p2) and (p(4) and g(3))) or ((p3 and p2) and (p(4) and p(3))and g(2)) or
((p3 and p2) and (p(4) and p(3))and (p(2) and g(1))) or ((p3 and p2) and p1 and g(0)) or
((p3 and p2) and (p1 and p(0)) and Cin);                                                                

c14 <= g(13) or (p(13) and g(12)) or (p(13) and p(12)and g(11)) or ((p(13) and p(12))and p(11)and g(10)) or 
((p(13) and p(12))and (p(11)and p(10)) and g(9)) or 
((p(13) and p(12))and (p(11)and p(10)) and p(9) and g(8)) or ((p(13) and p3 and p(8)) and g(7)) or 
((p(13) and p3 and p(8)) and (p(7) and g(6))) or ((p(13) and p3 and p(8)) and (p(7)and p(6))and g(5)) or 
((p(13) and p3) and (p2 and g(4))) or ((p(13) and p3) and (p2 and p(4)) and g(3)) or 
((p(13) and p3) and (p2 and p(4))and (p(3) and g(2))) or ((p(13) and p3) and (p2 and p(4))and (p(3)and p(2)) and g(1)) or 
((p(13) and p3) and (p2 and p1 and g(0))) or ((p(13) and p3) and (p2 and p1) and p(0) and Cin); 

c15 <= g(14) or (p(14) and g(13)) or (p(14) and p(13) and g(12)) or ((p(14) and p(13))and (p(12) and g(11))) or 
((p(14) and p(13))and (p(12)and p(11)) and g(10)) or 
((p(14) and p(13))and (p(12)and p(11))and (p(10) and g(9))) or ((p(14) and p(13))and p3 and g(8)) or 
((p(14) and p(13))and p3 and (p(8)and g(7))) or 
((p(14) and p(13))and p3 and (p(8)and p(7))and g(6)) or ((p(14) and p(13))and p3 and (p(8)and p(7))and (p(6) and g(5))) or 
((p(14) and p(13))and p3 and p2 and g(4)) or 
((p(14) and p(13))and (p3 and p2) and (p(4) and g(3))) or 
((p(14) and p(13))and (p3 and p2) and (p(4)and p(3))and g(2)) or 
((p(14) and p(13))and (p3 and p2) and (p(4)and p(3))and (p(2)and g(1))) or 
((p(14) and p(13))and (p3 and p2 and p1) and g(0)) or 
((p(14) and p(13))and (p3 and p2 and p1) and (p(0) and Cin));


c16 <= g(15) or (p(15) and g(14)) or ((p(15) and p(14))and g(13)) or ((p(15) and p(14))and (p(13)and g(12))) or 
((p(15) and p(14))and (p(13)and p(12))and g(11)) or 
((p(15) and p(14))and (p(13)and p(12))and (p(11)and g(10))) or 
((p(15) and p(14))and (p(13)and p(12))and (p(11)and p(10))and g(9)) or 
((p(15) and p(14))and (p(13)and p3 and g(8))) or ((p(15) and p(14))and (p(13)and p3 and p(8))and g(7)) or 
((p(15) and p(14))and (p(13)and p3) and (p(8) and p(7)and g(6))) or 
((p(15) and p(14))and (p(13)and p3 and p(8))and (p(7)and p(6))and g(5)) or 
((p(15) and p(14))and (p(13)and p3) and (p2 and g(4))) or 
((p(15) and p(14))and (p(13)and p3) and (p2 and p(4))and g(3)) or 
((p(15) and p(14))and (p(13)and p3) and (p2 and p(4))and (p(3)and g(2))) or 
((p(15) and p(14))and (p(13)and p3) and (p2 and p(4))and (p(3)and p(2))and g(1)) or 
((p(15) and p(14))and (p(13)and p3) and (p2 and p1 and g(0))) or 
((p(15) and p(14))and (p(13)and p3) and (p2 and p1 and p(0)) and Cin);

Cout <= g(16) or (p(16) and g(15)) or (p(16) and p(15) and g(14)) or ((p(16) and p(15))and p(14) and g(13)) or 
(p4 and g(12)) or
(p4 and p(12) and g(11)) or ((p4 and p(12)) and (p(11) and g(10))) or ((p4 and p(12)) and (p(11) and p(10)and g(9))) or
((p4 and p3) and g(8)) or ((p4 and p3)and (p(8)and g(7))) or
((p4 and p3)and (p(8)and p(7)) and g(6)) or ((p4 and p3)and (p(8)and p(7)) and (p(6)and g(5))) or
((p4 and p3)and p2 and g(4)) or 
((p4 and p3)and p2 and (p(4) and g(3))) or
((p4 and p3)and p2 and (p(4) and p(3)) and g(2)) or
((p4 and p3)and (p2 and p(4) and p(3)) and (p(2)and g(1))) or
((p4 and p3)and (p2 and p1) and g(0)) or
((p4 and p3)and (p2 and p1) and (p(0) and Cin));


S(0) <= p(0) xor Cin;

S(1) <= p(1) xor c1;

S(2) <= p(2) xor c2;

S(3) <= p(3) xor c3;

S(4) <= p(4) xor c4;

S(5) <= p(5) xor c5;

S(6) <= p(6) xor c6;

S(7) <= p(7) xor c7;

S(8) <= p(8) xor c8;

S(9) <= p(9) xor c9;

S(10) <= p(10) xor c10;

S(11) <= p(11) xor c11;

S(12) <= p(12) xor c12;

S(13) <= p(13) xor c13;

S(14) <= p(14) xor c14;

S(15) <= p(15) xor c15;

S(16) <= p(16) xor c16;

end Behavioral;