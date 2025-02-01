library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PSUBS is
  Port (
    A         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand A (64 biți)
    B         : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand B (64 biți)
    Size      : in  STD_LOGIC;                     -- Dimensiune: 0 = 8 biți, 1 = 16 biți
    Result    : out STD_LOGIC_VECTOR(63 downto 0)  -- Rezultatul final (64 biți)
  );
end PSUBS;

architecture Optimized of PSUBS is
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
  signal OverflowFlags  : STD_LOGIC_VECTOR(7 downto 0);
  signal Cin_next       : STD_LOGIC_VECTOR(7 downto 0);

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

  -- Instanțierea explicită a blocurilor AdderSubtractor8bit
    U0: AdderSubtractor8bit port map(A(7 downto 0), B(7 downto 0), Cin_next(0), '1', "11", PartialResults(7 downto 0), CoutFlags(0), OverflowFlags(0));
    U1: AdderSubtractor8bit port map(A(15 downto 8), B(15 downto 8), Cin_next(1), '1', "11", PartialResults(15 downto 8), CoutFlags(1), OverflowFlags(1));
    U2: AdderSubtractor8bit port map(A(23 downto 16), B(23 downto 16), Cin_next(2), '1', "11", PartialResults(23 downto 16), CoutFlags(2), OverflowFlags(2));
    U3: AdderSubtractor8bit port map(A(31 downto 24), B(31 downto 24), Cin_next(3), '1', "11", PartialResults(31 downto 24), CoutFlags(3), OverflowFlags(3));
    U4: AdderSubtractor8bit port map(A(39 downto 32), B(39 downto 32), Cin_next(4), '1', "11", PartialResults(39 downto 32), CoutFlags(4), OverflowFlags(4));
    U5: AdderSubtractor8bit port map(A(47 downto 40), B(47 downto 40), Cin_next(5), '1', "11", PartialResults(47 downto 40), CoutFlags(5), OverflowFlags(5));
    U6: AdderSubtractor8bit port map(A(55 downto 48), B(55 downto 48), Cin_next(6), '1', "11", PartialResults(55 downto 48), CoutFlags(6), OverflowFlags(6));
    U7: AdderSubtractor8bit port map(A(63 downto 56), B(63 downto 56), Cin_next(7), '1', "11", PartialResults(63 downto 56), CoutFlags(7), OverflowFlags(7));

  -- Rezultatul final în funcție de dimensiune
    process(PartialResults, OverflowFlags, Size)
    begin
        Result <= PartialResults; -- Implicit, wrap-around
        if Size = '0' then
            -- 8 biți: verificăm overflow pentru fiecare secțiune
            for i in 0 to 7 loop
                if OverflowFlags(i) = '1' then
                    Result((i+1)*8-1 downto i*8) <=
                        "01111111" when PartialResults((i+1)*8-1) = '0' else
                        "10000000";
                end if;
            end loop;
        elsif Size = '1' then
            -- 16 biți: verificăm overflow pentru perechi de secțiuni
            for i in 0 to 3 loop
                if OverflowFlags(2*i) = '1' or OverflowFlags(2*i+1) = '1' then
                    Result((2*i+2)*8-1 downto 2*i*8) <=
                        "0111111111111111" when PartialResults((2*i+2)*8-1) = '0' else
                        "1000000000000000";
                end if;
            end loop;
        end if;
    end process;

end Optimized;