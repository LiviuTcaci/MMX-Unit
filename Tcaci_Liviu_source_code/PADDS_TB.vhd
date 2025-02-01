library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PADDS_TB is
end PADDS_TB;

architecture Behavioral of PADDS_TB is
    -- Semnale pentru testare
    signal A       : STD_LOGIC_VECTOR(63 downto 0);
    signal B       : STD_LOGIC_VECTOR(63 downto 0);
    signal Size    : STD_LOGIC;
    signal Result  : STD_LOGIC_VECTOR(63 downto 0);

    -- Componenta sub test
    component PADDS
        Port (
            A       : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand A (64 biți)
            B       : in  STD_LOGIC_VECTOR(63 downto 0); -- Operand B (64 biți)
            Size    : in  STD_LOGIC;                     -- Dimensiune: 0 = 8 biți, 1 = 16 biți
            Result  : out STD_LOGIC_VECTOR(63 downto 0)  -- Rezultatul final (64 biți)
        );
    end component;

begin

    -- Instanțierea componentei PADDS
    UUT: PADDS port map(
        A => A,
        B => B,
        Size => Size,
        Result => Result
    );

    -- Proces de generare a testelor
    stim_proc: process
    begin
        -- ===== Teste pentru 8 biți =====
        -- Cazul 1: Adunare simpla 8-bit
        A <= x"0102030405060708";
        B <= x"0101010101010101";
        Size <= '0';
        wait for 10 ns;

        -- Cazul 2: Adunare cu saturare pozitiva 8-bit
        A <= x"7F7F7F7F7F7F7F7F";
        B <= x"0101010101010101";
        Size <= '0';
        wait for 10 ns;

        -- Cazul 3: Adunare cu saturare negativa 8-bit
        A <= x"8080808080808080";
        B <= x"0101010101010101";
        Size <= '0';
        wait for 10 ns;

        -- Cazul 4: Adunare zero 8-bit
        A <= x"0000000000000000";
        B <= x"0000000000000000";
        Size <= '0';
        wait for 10 ns;

        -- Cazul 5: Adunare cu valori mixte 8-bit
        A <= x"F0F0F0F0F0F0F0F0";
        B <= x"0F0F0F0F0F0F0F0F";
        Size <= '0';
        wait for 10 ns;

        -- ===== Teste pentru 16 biți =====
        -- Cazul 6: Adunare simpla 16-bit
        A <= x"0002000300040005";
        B <= x"0006000700080009";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 7: Adunare cu saturare pozitiva 16-bit
        A <= x"7FFF7FFF7FFF7FFF";
        B <= x"0001000100010001";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 8: Adunare cu saturare negativa 16-bit
        A <= x"8000800080008000";
        B <= x"0001000100010001";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 9: Adunare zero 16-bit
        A <= x"0000000000000000";
        B <= x"0000000000000000";
        Size <= '1';
        wait for 10 ns;

        -- Cazul 10: Adunare cu valori mixte 16-bit
        A <= x"00F000AA00CC00FF";
        B <= x"000F0001000F0000";
        Size <= '1';
        wait for 10 ns;

        -- Finalizare simulare
        wait;
    end process;

end Behavioral;