library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AdderSubtractor8bit is
    Port (
        A       : in  STD_LOGIC_VECTOR(7 downto 0);
        B       : in  STD_LOGIC_VECTOR(7 downto 0);
        Cin     : in  STD_LOGIC;
        Op      : in  STD_LOGIC;
        Mode    : in  STD_LOGIC_VECTOR(1 downto 0); -- 00 wrap-around unsigned, 01 wrap-around signed, 10 saturate unsigned, 11 saturate signed
        Result  : out STD_LOGIC_VECTOR(7 downto 0);
        Cout    : out STD_LOGIC;
        Overflow: out STD_LOGIC
    );
end AdderSubtractor8bit;

architecture Optimized of AdderSubtractor8bit is
    component AdderSubtractor1bit
        Port (
            A       : in  STD_LOGIC;
            B       : in  STD_LOGIC;
            Cin     : in  STD_LOGIC;
            Op      : in  STD_LOGIC;
            Result  : out STD_LOGIC;
            Cout    : out STD_LOGIC
        );
    end component;

    signal Carry : STD_LOGIC_VECTOR(7 downto 0);
    signal Ext_Result : STD_LOGIC_VECTOR(8 downto 0); -- Extindere pentru overflow
    signal Overflow_Pos, Overflow_Neg : STD_LOGIC;   -- Semnale overflow
begin
    -- Instanțierea AdderSubtractor1bit
    U0: AdderSubtractor1bit port map(A(0), B(0), Cin, Op, Ext_Result(0), Carry(0));
    U1: AdderSubtractor1bit port map(A(1), B(1), Carry(0), Op, Ext_Result(1), Carry(1));
    U2: AdderSubtractor1bit port map(A(2), B(2), Carry(1), Op, Ext_Result(2), Carry(2));
    U3: AdderSubtractor1bit port map(A(3), B(3), Carry(2), Op, Ext_Result(3), Carry(3));
    U4: AdderSubtractor1bit port map(A(4), B(4), Carry(3), Op, Ext_Result(4), Carry(4));
    U5: AdderSubtractor1bit port map(A(5), B(5), Carry(4), Op, Ext_Result(5), Carry(5));
    U6: AdderSubtractor1bit port map(A(6), B(6), Carry(5), Op, Ext_Result(6), Carry(6));
    U7: AdderSubtractor1bit port map(A(7), B(7), Carry(6), Op, Ext_Result(7), Carry(7));

    -- Extensia pentru ultimul bit
    Ext_Result(8) <= Carry(7);

    -- Overflow detection
    Overflow_Pos <= '1' when (A(7) = '0' and B(7) = '0' and Op = '0' and Ext_Result(7) = '1') else
        '1' when (A(7) = '0' and B(7) = '1' and Op = '1' and Ext_Result(7) = '1') else '0';
    Overflow_Neg <= '1' when (A(7) = '1' and B(7) = '1' and Op = '0' and Ext_Result(7) = '0') else
        '1' when (A(7) = '1' and B(7) = '0' and Op = '1' and Ext_Result(7) = '0') else '0';
    Overflow <= (Overflow_Pos or Overflow_Neg) when (Mode = "01" or Mode = "11") else '0';

    -- Result calculation
    Result <=
        Ext_Result(7 downto 0) when (Mode = "00" or Mode = "01") else
        "11111111" when (Mode = "10" and Ext_Result(8) = '1' and Op = '0') else
        "00000000" when (Mode = "10" and Ext_Result(8) = '1' and Op = '1') else
        "01111111" when (Mode = "11" and Overflow_Pos = '1') else
        "10000000" when (Mode = "11" and Overflow_Neg = '1') else
        Ext_Result(7 downto 0);

    -- Carry/Borrow output
    Cout <= Ext_Result(8);
end Optimized;