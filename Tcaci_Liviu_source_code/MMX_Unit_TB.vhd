library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MMX_Unit_TB is
end MMX_Unit_TB;

architecture Behavioral of MMX_Unit_TB is
    -- Semnale pentru conectarea la unitatea testată
    signal A, B: STD_LOGIC_VECTOR(63 downto 0);
    signal Control: STD_LOGIC_VECTOR(2 downto 0);
    signal Size: STD_LOGIC_VECTOR(1 downto 0);
    signal Result: STD_LOGIC_VECTOR(63 downto 0);

    -- Componenta MMX_Unit
    component MMX_Unit
        Port (
            A: in  STD_LOGIC_VECTOR(63 downto 0);
            B: in  STD_LOGIC_VECTOR(63 downto 0);
            Control: in  STD_LOGIC_VECTOR(2 downto 0);
            Size: in  STD_LOGIC_VECTOR(1 downto 0);
            Result: out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

begin

    -- Instanțierea unității MMX_Unit
    UUT: MMX_Unit port map(
        A => A,
        B => B,
        Control => Control,
        Size => Size,
        Result => Result
    );

    -- Proces pentru stimulare
    stim_proc: process
    begin
        -- ===== Teste pentru 8 biti =====
        -- Cazul 1: Adunare simpla 8-bit
        A <= x"0102030405060708";
        B <= x"0101010101010101";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 2: Zero
        A <= x"0000000000000000";
        B <= x"0000000000000000";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 3: xFF7FFF7FFF7FFF7F
        A <= x"FF7FFF7FFF7FFF7F";
        B <= x"0101010101010101";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 4: x8000800080008000
        A <= x"8000800080008000";
        B <= x"0101010101010101";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 5 Valori mixte
        A <= x"F0F0F0F0F0F0F0F0";
        B <= x"0F0F0F0F0F0F0F0F";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 6:
        A <= x"F00FAA55CC33FF00";
        B <= x"0F0FF55A33CC00FF";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 7: xFFFFFFFFFFFFFFFF
        A <= x"FFFFFFFFFFFFFFFF";
        B <= x"FFFFFFFFFFFFFFFF";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 8:
        A <= x"F0F1F2F3F4F5F6F7";
        B <= x"0F0E0D0C0B0A0908";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;


        -- ===== Teste pentru 16 biti =====
        -- Cazul 9:
        A <= x"0001000100010001";
        B <= x"0001000100010001";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 10:
        A <= x"0005000400030002";
        B <= x"0001000200010001";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 11:
        A <= x"7FFFFFFF7FFFFFFF";
        B <= x"0001000100010001";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 12:
        A <= x"0000000000000000";
        B <= x"0001000200030004";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 13:
        A <= x"7FFF7FFF7FFF7FFF";
        B <= x"7FFF7FFF7FFF7FFF";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        --Cazul 14:
        A <= x"8000000080000000";
        B <= x"0001000100010001";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        --Cazul 15: valori mixte
        A <= x"0000F0020000AA03";
        B <= x"0000000100000F01";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- ===== Teste pentru 32 biti =====
        -- Cazul 16:
        A <= x"0000000200000000";
        B <= x"0000000100000001";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 17:
        A <= x"FFFFFFFF80000000";
        B <= x"FFFFFFFF7FFFFFFF";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Cazul 18:
        A <= x"FFFFFFFF0000AA02";
        B <= x"0000000100000F01";
        Size <= "00";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Size <= "01";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "001";  -- PADDS
        wait for 10 ns;

        Control <= "010";  -- PADDUS
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        Control <= "100";  -- PSUBS
        wait for 10 ns;

        Control <= "101";  -- PMULLW
        wait for 10 ns;

        Control <= "110";  -- PMULHW
        wait for 10 ns;

        Size <= "10";
        Control <= "000";  -- PADD
        wait for 10 ns;

        Control <= "011";  -- PSUB
        wait for 10 ns;

        -- Oprirea simulării
        wait;
    end process;

end Behavioral;