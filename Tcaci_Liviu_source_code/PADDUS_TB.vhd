library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PADDUS_TB is
end PADDUS_TB;

architecture Behavioral of PADDUS_TB is
    -- Semnale pentru testare
    signal A       : STD_LOGIC_VECTOR(63 downto 0);
    signal B       : STD_LOGIC_VECTOR(63 downto 0);
    signal Size    : STD_LOGIC;
    signal Result  : STD_LOGIC_VECTOR(63 downto 0);

    -- Componenta sub test
    component PADDUS
        Port (
            A       : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand A (64 biți)
            B       : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand B (64 biți)
            Size    : in  STD_LOGIC;                     -- Dimensiune: 0 = 8 biți, 1 = 16 biți
            Result  : out STD_LOGIC_VECTOR(63 downto 0)  -- Rezultatul final (64 biți)
        );
    end component;

begin

    -- Instanțierea componentei PADDUS
    UUT: PADDUS port map(
        A => A,
        B => B,
        Size => Size,
        Result => Result
    );

    -- Proces de generare a testelor
    stim_proc: process
    begin
        -- ===== Teste pentru 8 biti =====
        -- Cazul 1: Adunare simpla 8-bit
        A <= x"0102030405060708"; -- Secțiuni: 01, 02, 03, 04, 05, 06, 07, 08
        B <= x"0101010101010101"; -- Adaugam 01 la fiecare secțiune
        Size <= '0'; -- 8-bit
        wait for 10 ns;

        -- Cazul 2: Adunare cu saturare pozitiva 8-bit
        A <= x"7F7F7F7F7F7F7F7F"; -- 127 în fiecare secțiune
        B <= x"0101010101010101"; -- Adaugam 1 la fiecare secțiune
        Size <= '0'; -- 8-bit
        wait for 10 ns;

        -- Cazul 3: Adunare cu saturare negativa 8-bit
        A <= x"FF7F7F7F7F7F7F7F"; -- 255 în prima secțiune, 127 în rest
        B <= x"0101010101010101"; -- Adaugam 1 la fiecare secțiune
        Size <= '0'; -- 8-bit
        wait for 10 ns;

        -- Cazul 4: Adunare zero 8-bit
        A <= x"0000000000000000"; -- 0 în fiecare secțiune
        B <= x"0000000000000000"; -- 0 în fiecare secțiune
        Size <= '0'; -- 8-bit
        wait for 10 ns;

        -- Cazul 5: Adunare cu valori mixte 8-bit
        A <= x"F0F0F0F0F0F0F0F0"; -- Diverse valori pe fiecare secțiune
        B <= x"0F0F0F0F0F0F0F0F"; -- Diverse valori pe fiecare secțiune
        Size <= '0'; -- 8-bit
        wait for 10 ns;

        -- ===== Teste pentru 16 biti =====
        -- Cazul 6: Adunare simpla 16-bit
        A <= x"0002000300040005"; -- Cuvinte: 0002, 0003, 0004, 0005
        B <= x"0006000700080009"; -- Cuvinte: 0006, 0007, 0008, 0009
        Size <= '1'; -- 16-bit
        wait for 10 ns;

        -- Cazul 7: Adunare cu saturare pozitiva 16-bit
        A <= x"7FFF7FFF7FFF7FFF"; -- 32767 în fiecare cuvânt
        B <= x"0001000100010001"; -- Adaugam 1 la fiecare cuvânt
        Size <= '1'; -- 16-bit
        wait for 10 ns;

        -- Cazul 8: Adunare cu saturare negativa 16-bit
        A <= x"FFFF8000FFFF8000"; -- 65535 și 32768 în fiecare cuvânt
        B <= x"0001000100010001"; -- Adaugam 1 la fiecare cuvânt
        Size <= '1'; -- 16-bit
        wait for 10 ns;

        -- Cazul 9: Adunare zero 16-bit
        A <= x"0000000000000000"; -- 0 în fiecare cuvânt
        B <= x"0000000000000000"; -- 0 în fiecare cuvânt
        Size <= '1'; -- 16-bit
        wait for 10 ns;

        -- Cazul 10: Adunare cu valori mixte 16-bit
        A <= x"00F000AA00CC00FF"; -- Diverse valori pe fiecare cuvânt
        B <= x"000F0001000F0000"; -- Diverse valori pe fiecare cuvânt
        Size <= '1'; -- 16-bit
        wait for 10 ns;

        -- Finalizare simulare
        wait;
    end process;

end Behavioral;