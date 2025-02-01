library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PSUBS_TB is
end PSUBS_TB;

architecture Behavioral of PSUBS_TB is
    -- Semnale pentru testare
    signal A       : STD_LOGIC_VECTOR(63 downto 0);
    signal B       : STD_LOGIC_VECTOR(63 downto 0);
    signal Size    : STD_LOGIC;
    signal Result  : STD_LOGIC_VECTOR(63 downto 0);

    -- Componenta sub test
    component PSUBS
        Port (
            A         : in  STD_LOGIC_VECTOR(63 downto 0);
            B         : in  STD_LOGIC_VECTOR(63 downto 0);
            Size      : in  STD_LOGIC;
            Result    : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

begin

    -- Instanteaza componenta PSUBS
    UUT: PSUBS port map(
        A => A,
        B => B,
        Size => Size,
        Result => Result
    );

    -- Proces de generare a testelor
    stim_proc: process
    begin
        -- ===== Teste pentru 8 biti =====
        -- Cazul 1: Scadere simpla 8-bit
        A <= x"0102030405060708";
        B <= x"0101010101010101";
        Size <= '0';
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"0000000000000000";
        Size <= '0';
        wait for 10 ns;


        -- Cazul 2: Scadere cu saturare pozitiva 8-bit
        A <= x"ff7fff7fff7fff7f";
        B <= x"0101010101010101";
        Size <= '0';
        wait for 10 ns;

        -- Cazul 3: Scadere cu saturare negativa 8-bit
        A <= x"8000800080008000";
        B <= x"0101010101010101";
        Size <= '0';
        wait for 10 ns;

        -- Cazul 4: Scadere zero 8-bit
        A <= x"f0f0f0f0f0f0f0f0";
        B <= x"0f0f0f0f0f0f0f0f";
        Size <= '0';
        wait for 10 ns;

        -- ===== Teste pentru 16 biti =====
        -- Cazul 5: Scadere cu valori mixte 8-bit
        A <= x"f00faa55cc33ff00";
        B <= x"0f0ff55a33cc00ff";
        Size <= '1';
        wait for 10 ns;


        -- Cazul 6: Scadere simpla 16-bit
        A <= x"ffffffffffffffff";
        B <= x"ffffffffffffffff";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 7: Scadere cu saturare pozitiva 16-bit
        A <= x"f0f1f2f3f4f5f6f7";
        B <= x"0f0e0d0c0b0a0908";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 8: Scadere cu saturare negativa 16-bit
        A <= x"0001000100010001";
        B <= x"0001000100010001";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 9: Scadere zero 16-bit
        A <= x"0005000400030002";
        B <= x"0001000200010001";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 10: Scadere cu valori mixte 16-bit
        A <= x"7fffffff7fffffff";
        B <= x"0001000100010001";
        Size <= '1';
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"0001000200030004";
        Size <= '1';
        wait for 10 ns;

        A <= x"7fff7fff7fff7fff";
        B <= x"7fff7fff7fff7fff";
        Size <= '1';
        wait for 10 ns;

        A <= x"8000000080000000";
        B <= x"0001000100010001";
        Size <= '1';
        wait for 10 ns;

        A <= x"0000f0020000aa03";
        B <= x"0000000100000f01";
        Size <= '1';
        wait for 10 ns;

        A <= x"0000000200000000";
        B <= x"0000000100000001";
        Size <= '1';
        wait for 10 ns;

        A <= x"ffffffff80000000";
        B <= x"ffffffff7fffffff";
        Size <= '1';
        wait for 10 ns;

        A <= x"ffffffff0000aa02";
        B <= x"0000000100000f01";
        Size <= '1';
        wait for 10 ns;

        -- Finalizare simulare
        wait;
    end process;

end Behavioral;