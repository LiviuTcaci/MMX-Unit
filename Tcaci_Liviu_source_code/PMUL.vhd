library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PMUL is
    Port (
        A       : in  STD_LOGIC_VECTOR(63 downto 0);  -- Vector de 64 biți, operandul A
        B       : in  STD_LOGIC_VECTOR(63 downto 0);  -- Vector de 64 biți, operandul B
        Mode    : in  STD_LOGIC;                      -- 0: PMULLW, 1: PMULHW
        Result  : out STD_LOGIC_VECTOR(63 downto 0)   -- Rezultatul pe 64 de biți
    );
end PMUL;

architecture Behavioral of PMUL is

    -- Componenta Multiplier16bit
    component Multiplier16bit
        Port (
            A       : in  STD_LOGIC_VECTOR(15 downto 0);  -- Operand pe 16 biți
            B       : in  STD_LOGIC_VECTOR(15 downto 0);  -- Operand pe 16 biți
            Mode    : in  STD_LOGIC;                      -- 0: PMULLW, 1: PMULHW
            Result  : out STD_LOGIC_VECTOR(15 downto 0)   -- Rezultatul pe 16 biți
        );
    end component;

    -- Semnale interne pentru sub-vectorii de 16 biți
    signal A0, A1, A2, A3 : STD_LOGIC_VECTOR(15 downto 0);
    signal B0, B1, B2, B3 : STD_LOGIC_VECTOR(15 downto 0);
    signal R0, R1, R2, R3 : STD_LOGIC_VECTOR(15 downto 0);  -- Rezultatele fiecărei instanțe

begin

    -- Împărțirea vectorilor A și B în 4 cuvinte de 16 biți
    A0 <= A(15 downto 0);
    A1 <= A(31 downto 16);
    A2 <= A(47 downto 32);
    A3 <= A(63 downto 48);

    B0 <= B(15 downto 0);
    B1 <= B(31 downto 16);
    B2 <= B(47 downto 32);
    B3 <= B(63 downto 48);

    -- Instanțele componentei Multiplier16bit
    M0: Multiplier16bit
        port map (
            A => A0,
            B => B0,
            Mode => Mode,
            Result => R0
        );

    M1: Multiplier16bit
        port map (
            A => A1,
            B => B1,
            Mode => Mode,
            Result => R1
        );

    M2: Multiplier16bit
        port map (
            A => A2,
            B => B2,
            Mode => Mode,
            Result => R2
        );

    M3: Multiplier16bit
        port map (
            A => A3,
            B => B3,
            Mode => Mode,
            Result => R3
        );

    -- Concatenarea rezultatelor celor patru multiplicări
    Result <= R3 & R2 & R1 & R0;

end Behavioral;