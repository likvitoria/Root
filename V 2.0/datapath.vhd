--------------------------------------------------------------------------
                            --Datapath --
--------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity ROOT is
    generic(DATA_WIDTH : INTEGER := 17);
    Port ( 
        data        : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
        rst         : in  STD_LOGIC;
        clk         : in  STD_LOGIC;
        wrIn        : in  STD_LOGIC;
        wrSquare    : in  STD_LOGIC;
        wrCount     : in  STD_LOGIC;
        mux         : in  STD_LOGIC;

        root        	  : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
        iguais, negativo  : out  STD_LOGIC);


	

end ROOT;

architecture Behavioral of ROOT is
  --saidas dos somadores e sub
    signal subre, add1, add2      : std_logic_vector (DATA_WIDTH - 1 downto 0);
  --saidas dos mux
    signal mout1, mout2, mout3, mout4    : std_logic_vector (DATA_WIDTH - 1 downto 0);
  --saidas dos registradores
    signal rout1, rout2, rout3    : std_logic_vector (DATA_WIDTH - 1 downto 0);
  --carry out 
    signal  cOut_sub     	    : std_logic;
    signal  cOut_add1, cOut_add2    : std_logic;

    


begin
    
    --Mux In
        muxIn: Entity work.mux_2_1
            generic map(DATA_WIDTH => DATA_WIDTH)
            port map(
                A0         => data,
                A1         => subre,
                S0         => mux,
                result     => mout1

        );

    --Mux Square
        muxSquare: Entity work.mux_2_1 
            generic map(DATA_WIDTH => DATA_WIDTH)
            port map(
                A0         => "00000000000000001",
                A1         => add1,
                S0         => mux,
                result     => mout2

        );

    --Mux Count
        muxCount: Entity work.mux_2_1
            generic map(DATA_WIDTH => DATA_WIDTH)
            port map(
                A0         => "00000000000000000",
                A1         => add2,
                S0         => mux,
                result     => mout3

        );
    --Mux Comparador
        muxZeroOrLess: Entity work.mux_2_1
            generic map(DATA_WIDTH => DATA_WIDTH)
            port map(
                A0         => data,
                A1         => subre,
                S0         => mux,
                result     => mout4

        );

    --Registrador Input
        regIn: Entity work.gen_reg 
            generic map(REG_WIDTH => DATA_WIDTH)
            port map(
                datain     => mout1,
                dataout    => rout1,
                enable     => wrIn,
                clock      => clk,
                set        => '0',
                reset      => rst 

        );

    --Registrador Square
        regSquare: Entity work.gen_reg 
            generic map(REG_WIDTH => DATA_WIDTH)
            port map(
                datain  => mout2,
                dataout => rout2,
                enable  => wrSquare,
                clock   => clk,
                set     => '0',
                reset   => rst 

        );

    --Registrador Count
        regCount: Entity work.gen_reg
            generic map(REG_WIDTH => DATA_WIDTH)
            port map(
                datain  => mout3,
                dataout => rout3,
                enable  => wrCount,
                clock   => clk,
                set     => '0',
                reset   => rst 


    );

    --Subtrator
        Sub: Entity work.AddSub 
            generic map(ADDSUB_WIDTH => DATA_WIDTH)
            port map(
                input0     => rout1,
                input1     => rout2,
                result     => subre,
                carry_in   => '0',
                carry_out  => cout_sub,
                ctrl       => '1'

        );


    --Add Square
        addSquare: Entity work.Carry_Look_Ahead 
            generic map(ADDER_WIDTH => DATA_WIDTH)
            port map(
                    A	       => rout2,
                    B          => "00000000000000010",
		    Cin	       => '0',
                    S          => add1,
                    Cout       => cout_add1

            );

    --Add Count
        addCount: Entity work.Carry_Look_Ahead 
            generic map(ADDER_WIDTH => DATA_WIDTH)
            port map(
                A     	  => rout3,
                B     	  => "00000000000000001",
		Cin	  => '0',
                S         => add2,
                Cout	  => cout_add2

        );

    --Comparador
        comp: Entity work.Comparator 
            generic map(COMP_WIDTH => DATA_WIDTH)
            port map(
                input0      => mout4,
                input1      => "00000000000000000",
                iguais      => iguais,
		um_maior   => negativo


        );

    --saida 
	root <= rout3;

end Behavioral;