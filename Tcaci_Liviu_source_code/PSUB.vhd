library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PSUB is
    Port (
        A         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand A (64 biți)
        B         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand B (64 biți)
        Size      : in  STD_LOGIC_VECTOR(1 downto 0);  -- Dimensiune: 00 = 8 biți, 01 = 16 biți, 10 = 32 biți
        Result    : out STD_LOGIC_VECTOR(63 downto 0)  -- Rezultatul final (64 biți)
    );
end PSUB;

architecture Optimized of PSUB is
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
    signal BoutFlags      : STD_LOGIC_VECTOR(7 downto 0);
    signal Bin_next       : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Setăm semnalul Cin pentru fiecare bloc explicit
    Bin_next(0) <= '0'; -- Primul bloc are carry-in fix 0
    Bin_next(1) <= BoutFlags(0) when (Size = "01" or Size = "10") else '0';
    Bin_next(2) <= BoutFlags(1) when (Size = "10") else '0';
    Bin_next(3) <= BoutFlags(2) when (Size = "01" or Size = "10") else '0';
    Bin_next(4) <= '0'; -- Blocurile superioare sunt independente pentru dimensiuni mici
    Bin_next(5) <= BoutFlags(4) when (Size = "01" or Size = "10") else '0';
    Bin_next(6) <= BoutFlags(5) when (Size = "10") else '0';
    Bin_next(7) <= BoutFlags(6) when (Size = "01" or Size = "10") else '0';

    -- Instanțierea explicită a blocurilor AdderSubtractor8bit
    U0: AdderSubtractor8bit port map(A(7 downto 0), B(7 downto 0), Bin_next(0), '1', "00", PartialResults(7 downto 0), BoutFlags(0), open);
    U1: AdderSubtractor8bit port map(A(15 downto 8), B(15 downto 8), Bin_next(1), '1', "00", PartialResults(15 downto 8), BoutFlags(1), open);
    U2: AdderSubtractor8bit port map(A(23 downto 16), B(23 downto 16), Bin_next(2), '1', "00", PartialResults(23 downto 16), BoutFlags(2), open);
    U3: AdderSubtractor8bit port map(A(31 downto 24), B(31 downto 24), Bin_next(3), '1', "00", PartialResults(31 downto 24), BoutFlags(3), open);
    U4: AdderSubtractor8bit port map(A(39 downto 32), B(39 downto 32), Bin_next(4), '1', "00", PartialResults(39 downto 32), BoutFlags(4), open);
    U5: AdderSubtractor8bit port map(A(47 downto 40), B(47 downto 40), Bin_next(5), '1', "00", PartialResults(47 downto 40), BoutFlags(5), open);
    U6: AdderSubtractor8bit port map(A(55 downto 48), B(55 downto 48), Bin_next(6), '1', "00", PartialResults(55 downto 48), BoutFlags(6), open);
    U7: AdderSubtractor8bit port map(A(63 downto 56), B(63 downto 56), Bin_next(7), '1', "00", PartialResults(63 downto 56), BoutFlags(7), open);

    -- Rezultatul final în funcție de dimensiune
    Result <= PartialResults;

end Optimized;