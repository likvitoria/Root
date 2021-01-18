--------------------------------------------------------------------------
                            --MAIN --
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity main is
	Port ( 

        clk, rst_n	   : in std_logic;
		data		   : in std_logic_vector(16 downto 0);
		root		   : out std_logic_vector(16 downto 0);
		ready		   : out std_logic
	
	);


end main; 


architecture structural of main is 
signal zero, ig, neg, muxs 	: std_logic;
signal wr_cnt, wr_in, wr_sqr	: std_logic;
	
begin 

	path : entity work.ROOT
	port map(
		clk => clk,
		rst => rst_n,
		data => data,
		mux => muxs,
		wrCount => wr_cnt,
		wrIn => wr_in,
		wrSquare => wr_sqr,
		root => root,
		iguais => ig,
		negativo => neg

	);

	cntrol : entity work.control
	port map(
		clk => clk,
		rst => rst_n,
		iguais => ig,
		negativo => neg,
		ready => ready,
		mux => muxs,
		wrCount => wr_cnt,
		wrIn => wr_in,
		wrSquare => wr_sqr

	);

end structural;

		