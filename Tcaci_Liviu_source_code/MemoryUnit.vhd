library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MemoryUnit is
    Port (
        clk       : in  STD_LOGIC;                        -- Semnalul de ceas
        BtnUp     : in  STD_LOGIC;                        -- Buton pentru incrementare
        BtnDown   : in  STD_LOGIC;                        -- Buton pentru decrementare
        BtnCenter : in  STD_LOGIC;                        -- Buton pentru resetare
        A         : out STD_LOGIC_VECTOR(63 downto 0);    -- Vectorul A curent
        B         : out STD_LOGIC_VECTOR(63 downto 0);    -- Vectorul B curent
        index_out : out STD_LOGIC_VECTOR(9 downto 0)      -- Indexul curent (9 biți)
    );
end MemoryUnit;

architecture Behavioral of MemoryUnit is
    -- Setăm numărul de perechi de vectori în memorie
    constant MEM_DEPTH : integer := 18; -- 18 elemente

    -- Definirea tipului de memorie utilizând `record`
    type memory_element is record
        vecA : STD_LOGIC_VECTOR(63 downto 0); -- Vectorul A
        vecB : STD_LOGIC_VECTOR(63 downto 0); -- Vectorul B
    end record;

    type memory_type is array (0 to MEM_DEPTH-1) of memory_element;

    -- Instanța memoriei cu valori predefinite
    signal memory : memory_type := (
        0  => (vecA => x"0102030405060708", vecB => x"0101010101010101"),
        1  => (vecA => x"0000000000000000", vecB => x"0000000000000000"),
        2  => (vecA => x"FF7FFF7FFF7FFF7F", vecB => x"0101010101010101"),
        3  => (vecA => x"8000800080008000", vecB => x"0101010101010101"),
        4  => (vecA => x"F0F0F0F0F0F0F0F0", vecB => x"0F0F0F0F0F0F0F0F"),
        5  => (vecA => x"F00FAA55CC33FF00", vecB => x"0F0FF55A33CC00FF"),
        6  => (vecA => x"FFFFFFFFFFFFFFFF", vecB => x"FFFFFFFFFFFFFFFF"),
        7  => (vecA => x"F0F1F2F3F4F5F6F7", vecB => x"0F0E0D0C0B0A0908"),
        8  => (vecA => x"0001000100010001", vecB => x"0001000100010001"),
        9  => (vecA => x"0005000400030002", vecB => x"0001000200010001"),
        10 => (vecA => x"7fffffff7fffffff", vecB => x"0001000100010001"),
        11 => (vecA => x"0000000000000000", vecB => x"0001000200030004"),
        12 => (vecA => x"7fff7fff7fff7fff", vecB => x"7fff7fff7fff7fff"),
        13 => (vecA => x"8000000080000000", vecB => x"0001000100010001"),
        14 => (vecA => x"0000F0020000AA03", vecB => x"0000000100000F01"),
        15 => (vecA => x"0000000200000000", vecB => x"0000000100000001"),
        16 => (vecA => x"FFFFFFFF80000000", vecB => x"FFFFFFFF7FFFFFFF"),
        17 => (vecA => x"FFFFFFFF0000AA02", vecB => x"0000000100000F01")
    );

    -- Indexul curent pentru accesarea memoriei
    signal index : integer range 0 to MEM_DEPTH-1 := 0;

begin
    -- Gestionarea indexului curent
    process(clk)
    begin
        if rising_edge(clk) then
            if BtnCenter = '1' then
                index <= 0; -- Reset la poziția 0
            elsif BtnUp = '1' then
                if index < MEM_DEPTH-1 then
                    index <= index + 1; -- Incrementare
                end if;
            elsif BtnDown = '1' then
                if index > 0 then
                    index <= index - 1; -- Decrementare
                end if;
            end if;
        end if;
    end process;

    -- Ieșirile vectorilor A și B
    A <= memory(index).vecA;
    B <= memory(index).vecB;

    -- Conversia indexului în binar corect dimensionat
    index_out <= std_logic_vector(to_unsigned(index, 10)); -- Indexul în format binar
end Behavioral;