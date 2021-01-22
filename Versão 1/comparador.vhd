--------------------------------------------------------------------------
--                            Comparator                                --
--------------------------------------------------------------------------


library ieee;
    use ieee.std_logic_1164.all;
    
package Comp_package is

component Comparator is 
    generic(COMP_WIDTH : INTEGER := 17);
    port (	
        input0      : in std_logic_vector(COMP_WIDTH - 1 downto 0);
        input1      : in std_logic_vector(COMP_WIDTH - 1 downto 0);
        iguais      : out std_logic;
        zero_maior  : out std_logic;
        um_maior    : out std_logic
        );

end component;
        
end Comp_package;


library ieee;
    use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;

entity Comparator is 
    generic(COMP_WIDTH : INTEGER := 17);
	port (	
		input0      : in std_logic_vector(COMP_WIDTH - 1 downto 0);
        input1      : in std_logic_vector(COMP_WIDTH - 1 downto 0);
        
        iguais      : out std_logic;
        zero_maior  : out std_logic;
        um_maior    : out std_logic
        
		);
end Comparator;


architecture dataflow of Comparator is
    signal signal0, signal1 : SIGNED(COMP_WIDTH - 1 downto 0);

begin

   signal0 <= SIGNED(input0);
   signal1 <= SIGNED(input1);

   zero_maior <= '1' when signal0 > signal1 else '0';
   um_maior <= '1' when signal1 > signal0 else '0';
   iguais	<= '1' when input0 = input1 else '0';
	

end dataflow;