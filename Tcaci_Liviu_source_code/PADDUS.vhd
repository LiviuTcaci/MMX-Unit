library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PADDUS is
  Port (
    A         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand A (64 biți)
    B         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand B (64 biți)
    Size      : in  STD_LOGIC;                     -- Dimensiune: 0 = 8 biți, 1 = 16 biți
    Result    : out STD_LOGIC_VECTOR(63 downto 0)  -- Rezultatul final (64 biți)
  );
end PADDUS;

architecture Optimized of PADDUS is
    component AdderSubtractor8bit
        Port (
            A       : in  STD_LOGIC_VECTOR(7 downto 0);
            B       : in  STD_LOGIC_VECTOR(7 downto 0);
            Cin     : in  STD_LOGIC;
            Op      : in  STD_LOGIC;
            Mode    : in  STD_LOGIC_VECTOR(1 downto 0); -- 00 wrap-around unsigned, 10 saturate unsigned
            Result  : out STD_LOGIC_VECTOR(7 downto 0);
            Cout    : out STD_LOGIC;
            Overflow: out STD_LOGIC
        );
    end component;

    -- Semnale interne
    signal PartialResults : STD_LOGIC_VECTOR(63 downto 0);
    signal CoutFlags      : STD_LOGIC_VECTOR(7 downto 0);
    signal OverflowFlags  : STD_LOGIC_VECTOR(7 downto 0);
    signal Cin_next       : STD_LOGIC_VECTOR(7 downto 0);
    signal AdderSubtractor_Mode : STD_LOGIC_VECTOR(1 downto 0); -- Nou

begin
    -- Setăm semnalul Cin pentru fiecare bloc explicit
    Cin_next(0) <= '0'; -- Primul bloc are carry-in fix 0
    Cin_next(1) <= CoutFlags(0) when (Size = '1') else '0';
    Cin_next(2) <= '0';
    Cin_next(3) <= CoutFlags(2) when (Size = '1') else '0';
    Cin_next(4) <= '0'; -- Blocurile superioare sunt independente pentru dimensiuni mici
    Cin_next(5) <= CoutFlags(4) when (Size = '1') else '0';
    Cin_next(6) <= '0';
    Cin_next(7) <= CoutFlags(6) when (Size = '1') else '0';

    -- Setăm modul în funcție de dimensiune
    AdderSubtractor_Mode <= "10" when Size = '0' else "00";

    -- Instanțierea explicită a blocurilor AdderSubtractor8bit
    U0: AdderSubtractor8bit port map(
        A => A(7 downto 0),
        B => B(7 downto 0),
        Cin => Cin_next(0),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(7 downto 0),
        Cout => CoutFlags(0),
        Overflow => OverflowFlags(0)
    );

    U1: AdderSubtractor8bit port map(
        A => A(15 downto 8),
        B => B(15 downto 8),
        Cin => Cin_next(1),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(15 downto 8),
        Cout => CoutFlags(1),
        Overflow => OverflowFlags(1)
    );

    U2: AdderSubtractor8bit port map(
        A => A(23 downto 16),
        B => B(23 downto 16),
        Cin => Cin_next(2),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(23 downto 16),
        Cout => CoutFlags(2),
        Overflow => OverflowFlags(2)
    );

    U3: AdderSubtractor8bit port map(
        A => A(31 downto 24),
        B => B(31 downto 24),
        Cin => Cin_next(3),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(31 downto 24),
        Cout => CoutFlags(3),
        Overflow => OverflowFlags(3)
    );

    U4: AdderSubtractor8bit port map(
        A => A(39 downto 32),
        B => B(39 downto 32),
        Cin => Cin_next(4),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(39 downto 32),
        Cout => CoutFlags(4),
        Overflow => OverflowFlags(4)
    );

    U5: AdderSubtractor8bit port map(
        A => A(47 downto 40),
        B => B(47 downto 40),
        Cin => Cin_next(5),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(47 downto 40),
        Cout => CoutFlags(5),
        Overflow => OverflowFlags(5)
    );

    U6: AdderSubtractor8bit port map(
        A => A(55 downto 48),
        B => B(55 downto 48),
        Cin => Cin_next(6),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(55 downto 48),
        Cout => CoutFlags(6),
        Overflow => OverflowFlags(6)
    );

    U7: AdderSubtractor8bit port map(
        A => A(63 downto 56),
        B => B(63 downto 56),
        Cin => Cin_next(7),
        Op => '0',
        Mode => AdderSubtractor_Mode,
        Result => PartialResults(63 downto 56),
        Cout => CoutFlags(7),
        Overflow => OverflowFlags(7)
    );

    -- Rezultatul final în funcție de dimensiune
    process(PartialResults, CoutFlags, Size)
    begin
        Result <= PartialResults; -- Implicit, wrap-around

        if Size = '0' then
            -- 8 biți: verificăm overflow pentru fiecare secțiune
            for i in 0 to 7 loop
                if OverflowFlags(i) = '1' then
                    Result((i+1)*8-1 downto i*8) <=
                        "11111111" when PartialResults((i+1)*8-1) = '0' else
                        "00000000";
                end if;
            end loop;
        elsif Size = '1' then
            -- 16 biți: verificăm carry-out de la partea superioară a fiecărui cuvânt
            for i in 0 to 3 loop
                if CoutFlags(2*i +1) = '1' then
                    Result((2*i +2)*8-1 downto 2*i*8) <= "1111111111111111";
                end if;
            end loop;
        end if;
    end process;
end Optimized;