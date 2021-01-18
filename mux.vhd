--------------------------------------------------------------------------
--  Entidade Multiplexador 2 X 1
--------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;

package mux_package is

component mux_2_1 is
  generic(DATA_WIDTH : INTEGER := 17);
  port(
        A0  : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        A1  : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        s0  : in std_logic;
        result  : out std_logic_vector(DATA_WIDTH - 1 downto 0)
      );
end component;

end mux_package;


library ieee;
	use ieee.std_logic_1164.all;        
	use ieee.std_logic_unsigned.all;

entity mux_2_1 is
  generic(DATA_WIDTH : INTEGER := 17);
  port(
        A0  : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        A1  : in std_logic_vector(DATA_WIDTH - 1 downto 0);
        s0  : in std_logic;
        result  : out std_logic_vector(DATA_WIDTH - 1 downto 0)
      );
end mux_2_1;

architecture dataflow of mux_2_1 is
signal sel : std_logic_vector(DATA_WIDTH - 1 downto 0);
begin
   process(A0,A1,s0)
   begin
	if s0 = '0' then
		sel <= A0;
	elsif s0 = '1' then
		sel <= A1;
	end if;
   end process;
    result <= sel;
END dataflow;
