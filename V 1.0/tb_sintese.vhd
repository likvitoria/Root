--------------------------------------------------------------------------
                            --Test bench --
--------------------------------------------------------------------------


library ieee;
use iEEE.std_logic_1164.all;
use iEEE.std_logic_signed.all;
 
 
ENTITY int_sqrt_tb is
	
END int_sqrt_tb;
 
architecture behavior of int_sqrt_tb is 
 
    COMPONENT main
    PORT(
        	clk, rst_n	   : in std_logic;
		data		   : in std_logic_vector(16 downto 0);
		root		   : out std_logic_vector(16 downto 0);
		ready		   : out std_logic

        );
    END COMPONENT;
    

   --Inputs
	signal clk : std_logic := '0';
	signal rst_n : std_logic := '0';
	signal data : std_logic_vector(16 downto 0) := "00000000000100100";

   --Outputs
	signal root : std_logic_vector(16 downto 0);
	signal ready : std_logic := '1';

   -- Clock period definitions
        constant clock_period : time := 1.5 ns;
	
	signal count : std_logic_vector(8 downto 0) := "000000000";


 
begin
-- Instantiate the Unit Under Test (UUT)
   DUV: main  PORT MAP (
          clk,
	  rst_n,
          data,
          root,
          ready

        );

   	rst_n <= '1', '0' after 0.2 ns;
	clk <= not clk after 5 ns;


 


end architecture behavior;