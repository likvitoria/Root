--------------------------------------------------------------------------
                            --Data --
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

        root        : out  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
        iguais, negativo  : out  STD_LOGIC);


	

end ROOT;

architecture Behavioral of ROOT is
  --adder/addsub output
    signal subre, add1, add2      : std_logic_vector (DATA_WIDTH - 1 downto 0);
  --mux output
    signal mout1, mout2, mout3, mout4    : std_logic_vector (DATA_WIDTH - 1 downto 0);
  --register output
    signal rout1, rout2, rout3    : std_logic_vector (DATA_WIDTH - 1 downto 0);
  --carry out 
    signal  cOut_sub     : std_logic;
    signal  cOut_add1    : std_logic;
    signal  cOut_add2    : std_logic;


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
                set        => '0',
                reset      => rst,
                enable     => wrIn,
                clock      => clk, 
                dataout    => rout1

        );

    --Registrador Square
        regSquare: Entity work.gen_reg 
            generic map(REG_WIDTH => DATA_WIDTH)
            port map(
                datain  => mout2,
		        set     => '0',
                reset   => rst,
                enable  => wrSquare,
                clock   => clk,
                dataout => rout2

  

        );

    --Registrador Count
        regCount: Entity work.gen_reg
            generic map(REG_WIDTH => DATA_WIDTH)
            port map(
                datain  => mout3,
                set     => '0',
                reset   => rst,
                enable  => wrCount,
             	clock   => clk,
                dataout => rout3
 


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
        addSquare: Entity work.Adder 
            generic map(ADDER_WIDTH => DATA_WIDTH)
            port map(
                    input0     => rout2,
                    input1     => "00000000000000010",
                    result     => add1,
                    carry_in   => '0',
                    carry_out  => cout_add1

            );

    --Add Count
        addCount: Entity work.Adder 
            generic map(ADDER_WIDTH => DATA_WIDTH)
            port map(
                input0     => rout3,
                input1     => "00000000000000001",
                result     => add2,
                carry_in   => '0',
                carry_out  => cout_add2

        );

    --Comparator
        comp: Entity work.Comparator 
            generic map(COMP_WIDTH => DATA_WIDTH)
            port map(
                input0      => mout4,
                input1      => "00000000000000000",
                iguais      => iguais,
		        um_maior   => negativo


        );

    --result
	root <= rout3;

end Behavioral;