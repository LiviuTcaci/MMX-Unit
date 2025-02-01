library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AdderSubtractor8bit_TB is
end AdderSubtractor8bit_TB;

architecture Behavioral of AdderSubtractor8bit_TB is
    -- Componenta testată
    component AdderSubtractor8bit
        Port (
            A       : in  STD_LOGIC_VECTOR(7 downto 0);
            B       : in  STD_LOGIC_VECTOR(7 downto 0);
            Cin     : in  STD_LOGIC;
            Op      : in  STD_LOGIC;
            Mode    : in  STD_LOGIC_VECTOR(1 downto 0);
            Result  : out STD_LOGIC_VECTOR(7 downto 0);
            Cout    : out STD_LOGIC;
            Overflow: out STD_LOGIC
        );
    end component;

    -- Semnale pentru testare
    signal A, B : STD_LOGIC_VECTOR(7 downto 0);
    signal Cin  : STD_LOGIC;
    signal Op   : STD_LOGIC;
    signal Mode : STD_LOGIC_VECTOR(1 downto 0);
    signal Result : STD_LOGIC_VECTOR(7 downto 0);
    signal Cout    : STD_LOGIC;
    signal Overflow: STD_LOGIC;

begin
    -- Instanțierea componentei
    UUT: AdderSubtractor8bit
        Port map (
            A       => A,
            B       => B,
            Cin     => Cin,
            Op      => Op,
            Mode    => Mode,
            Result  => Result,
            Cout    => Cout,
            Overflow => Overflow
        );

    -- Proces de generare a stimulilor
    Stimulus: process
    begin
        -- Adunare (Op = 0)
        Op <= '0';

        -- Mod 00: Wrap-around nesemnat
        Mode <= "00";
        Cin <= '0';
        A <= "00001111"; B <= "00000001"; wait for 20 ns;
        A <= "11111111"; B <= "00000001"; wait for 20 ns;

        -- Mod 10: Saturare nesemnată
        Mode <= "10";
        A <= "11111111"; B <= "00000001"; wait for 20 ns;
        A <= "00000010"; B <= "00000001"; wait for 20 ns;

        -- Mod 01: Wrap-around semnat
        Mode <= "01";
        A <= "01111111"; B <= "00000001"; wait for 20 ns;
        A <= "10000000"; B <= "11111111"; wait for 20 ns;

        -- Mod 11: Saturare semnată
        Mode <= "11";
        A <= "01111111"; B <= "00000001"; wait for 20 ns;
        A <= "10000000"; B <= "11111111"; wait for 20 ns;
        A <= "00000010"; B <= "00000001"; wait for 20 ns;

        -- Scădere (Op = 1)
        Op <= '1';

        -- Mod 00: Wrap-around nesemnat
        Mode <= "00";
        A <= "00001111"; B <= "00000001"; wait for 20 ns;
        A <= "00000000"; B <= "00000001"; wait for 20 ns;

        -- Mod 10: Saturare nesemnată
        Mode <= "10";
        A <= "00000000"; B <= "00000001"; wait for 20 ns;
        A <= "00001010"; B <= "00000001"; wait for 20 ns;

        -- Mod 01: Wrap-around semnat
        Mode <= "01";
        A <= "01111111"; B <= "11111111"; wait for 20 ns;
        A <= "10000000"; B <= "00000001"; wait for 20 ns;

        -- Mod 11: Saturare semnată
        Mode <= "11";
        A <= "10000000"; B <= "00000001"; wait for 20 ns;
        A <= "01111111"; B <= "11111111"; wait for 20 ns;
        A <= "00001010"; B <= "00000001"; wait for 20 ns;

        -- Finalizare simulare
        wait;
    end process;

end Behavioral;