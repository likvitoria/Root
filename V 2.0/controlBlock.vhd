------------------------------------------------------------------------
	--	Control Block       --
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;




entity control is
	port (  
		clk, rst	    		    : in std_logic;
        iguais, negativo            : in std_logic;
        
        wrCount, wrIn, wrSquare 	: out std_logic;
        ready, mux              	: out std_logic
 		       
        
	);
end control;
                   

architecture behavioral of control is 
        
    type State is (S0, S2, S3);
    signal currentState, nextState : State;
    
begin
    
    -- State memory
    process(clk, rst)
    begin
        
        if rst = '1' then
            currentState <= S0;
        
        elsif rising_edge(clk) then
            currentState <= nextState;
            
        end if;
    end process;
    
    -- Next state logic
    process( rst, iguais, negativo, clk)
    begin
        
        case currentState is
            when S0 =>
                if iguais = '1' then
                    nextState <= S3;
                else
                    nextState <= S2;
                end if;   
                
            when S2 =>
		        if negativo = '1' or iguais = '1' then
			        nextState <= S3;
		        else
			        nextState <= S2;
			end if;   
	     when S3 =>
                    nextState <= S3;	  
		           
            
        end case;
        
    end process;
    
    -- Output logic
    wrCount     <= '1' when currentState = S0 or currentState = S2 else '0';
    wrSquare    <= '1' when currentState = S0 or currentState = S2 else '0';
    wrIn        <= '1' when currentState = S0 or currentState = S2 else '0';
    ready       <= '1' when currentState = S0 or currentState = S2 else '0';
    mux         <= '0' when currentState = S0 else '1';





    
    
end behavioral;
