library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PADD is
    Port (
        A         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand A (64 biți)
        B         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand B (64 biți)
        Size      : in  STD_LOGIC_VECTOR(1 downto 0);  -- Dimensiune: 00 = 8 biți, 01 = 16 biți, 10 = 32 biți
        Result    : out STD_LOGIC_VECTOR(63 downto 0)  -- Rezultatul final (64 biți)
    );
end PADD;

architecture Optimized of PADD is
    component AdderSubtractor8bit
        Port (
            A       : in  STD_LOGIC_VECTOR(7 downto 0);
            B       : in  STD_LOGIC_VECTOR(7 downto 0);
            Cin     : in  STD_LOGIC;
            Op      : in  STD_LOGIC;
            Mode    : in  STD_LOGIC_VECTOR(1 downto 0); -- 00 wrap-around unsigned, 10 saturate unsigned, 11 saturate signed
            Result  : out STD_LOGIC_VECTOR(7 downto 0);
            Cout    : out STD_LOGIC;
            Overflow: out STD_LOGIC
        );
    end component;

    -- Semnale interne
    signal PartialResults : STD_LOGIC_VECTOR(63 downto 0);
    signal CoutFlags      : STD_LOGIC_VECTOR(7 downto 0);
    signal Cin_next       : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Setăm semnalul Cin pentru fiecare bloc explicit
    Cin_next(0) <= '0'; -- Primul bloc are carry-in fix 0
    Cin_next(1) <= CoutFlags(0) when (Size = "01" or Size = "10") else '0';
    Cin_next(2) <= CoutFlags(1) when (Size = "10") else '0';
    Cin_next(3) <= CoutFlags(2) when (Size = "01" or Size = "10") else '0';
    Cin_next(4) <= '0'; -- Blocurile superioare sunt independente pentru dimensiuni mici
    Cin_next(5) <= CoutFlags(4) when (Size = "01" or Size = "10") else '0';
    Cin_next(6) <= CoutFlags(5) when (Size = "10") else '0';
    Cin_next(7) <= CoutFlags(6) when (Size = "01" or Size = "10") else '0';

    -- Instanțierea explicită a blocurilor AdderSubtractor8bit
    U0: AdderSubtractor8bit port map(A(7 downto 0), B(7 downto 0), Cin_next(0), '0', "00", PartialResults(7 downto 0), CoutFlags(0), open);
    U1: AdderSubtractor8bit port map(A(15 downto 8), B(15 downto 8), Cin_next(1), '0', "00", PartialResults(15 downto 8), CoutFlags(1), open);
    U2: AdderSubtractor8bit port map(A(23 downto 16), B(23 downto 16), Cin_next(2), '0', "00", PartialResults(23 downto 16), CoutFlags(2), open);
    U3: AdderSubtractor8bit port map(A(31 downto 24), B(31 downto 24), Cin_next(3), '0', "00", PartialResults(31 downto 24), CoutFlags(3), open);
    U4: AdderSubtractor8bit port map(A(39 downto 32), B(39 downto 32), Cin_next(4), '0', "00", PartialResults(39 downto 32), CoutFlags(4), open);
    U5: AdderSubtractor8bit port map(A(47 downto 40), B(47 downto 40), Cin_next(5), '0', "00", PartialResults(47 downto 40), CoutFlags(5), open);
    U6: AdderSubtractor8bit port map(A(55 downto 48), B(55 downto 48), Cin_next(6), '0', "00", PartialResults(55 downto 48), CoutFlags(6), open);
    U7: AdderSubtractor8bit port map(A(63 downto 56), B(63 downto 56), Cin_next(7), '0', "00", PartialResults(63 downto 56), CoutFlags(7), open);
    
    -- Rezultatul final în funcție de dimensiune
    Result <= PartialResults;

end Optimized;