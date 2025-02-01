library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PADD_TB is
end PADD_TB;

architecture Behavioral of PADD_TB is

    -- Semnalele pentru testare
    signal A, B     : STD_LOGIC_VECTOR(63 downto 0);
    signal Size     : STD_LOGIC_VECTOR(1 downto 0);
    signal Result   : STD_LOGIC_VECTOR(63 downto 0);

    -- Componenta sub test
    component PADD is
        Port (
            A       : in  STD_LOGIC_VECTOR(63 downto 0);
            B       : in  STD_LOGIC_VECTOR(63 downto 0);
            Size    : in  STD_LOGIC_VECTOR(1 downto 0);
            Result  : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

begin

    -- Instantierea componentei sub test
    DUT: PADD port map (A, B, Size, Result);

    -- Proces de generare a testelor
    Stimulus: process
    begin
        -- ===== Teste pentru 8 biti =====
        A <= x"0101010101010101";
        B <= x"0101010101010101";
        Size <= "00";
        wait for 10 ns;

        A <= x"FFFFFFFFFFFFFFFF";
        B <= x"0101010101010101";
        Size <= "00";
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"0000000000000000";
        Size <= "00";
        wait for 10 ns;

        A <= x"0102030405060708";
        B <= x"0101010101010101";
        Size <= "00";
        wait for 10 ns;

        A <= x"F00FAA55CC33FF00";
        B <= x"0F0FF55A33CC00FF";
        Size <= "00";
        wait for 10 ns;

        -- ===== Teste pentru 16 biti =====
        A <= x"0002000300040005";
        B <= x"0006000700080009";
        Size <= "01";
        wait for 10 ns;

        A <= x"FFFF0000FFFF0000";
        B <= x"0001000100010001";
        Size <= "01";
        wait for 10 ns;

        A <= x"0002000300040005";
        B <= x"0001000100010001";
        Size <= "01";
        wait for 10 ns;

        A <= x"00F000AA00CC00FF";
        B <= x"000F0001000F0000";
        Size <= "01";
        wait for 10 ns;

        -- ===== Teste pentru 32 biti =====
        A <= x"FFFFFFFF00000000";
        B <= x"FFFFFFFF00000000";
        Size <= "10";
        wait for 10 ns;

        A <= x"FFFFFFFFFFFFFFFF";
        B <= x"0000000100000001";
        Size <= "10";
        wait for 10 ns;

        A <= x"0000000100000002";
        B <= x"0000000100000001";
        Size <= "10";
        wait for 10 ns;

        A <= x"0000F0010000AA02";
        B <= x"0000000100000F01";
        Size <= "10";
        wait for 10 ns;

        A <= x"0101010101010101";
        B <= x"0101010101010101";
        Size <= "10";
        wait for 10 ns;

        A <= x"FFFFFFFFFFFFFFFF";
        B <= x"FFFFFFFFFFFFFFFF";
        Size <= "10";
        wait for 10 ns;

        -- Finalizare simulare
        wait;
    end process;

end Behavioral;