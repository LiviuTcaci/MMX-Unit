library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PSUB_TB is
end PSUB_TB;

architecture Behavioral of PSUB_TB is

    signal A, B     : STD_LOGIC_VECTOR(63 downto 0);
    signal Size     : STD_LOGIC_VECTOR(1 downto 0);
    signal Result   : STD_LOGIC_VECTOR(63 downto 0);

    component PSUB is
        Port (
            A       : in  STD_LOGIC_VECTOR(63 downto 0);
            B       : in  STD_LOGIC_VECTOR(63 downto 0);
            Size    : in  STD_LOGIC_VECTOR(1 downto 0);
            Result  : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

begin

    DUT: PSUB port map (A, B, Size, Result);

    Stimulus: process
    begin
        A <= x"0102030405060708";
        B <= x"0101010101010101";
        Size <= "00";
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"0101010101010101";
        Size <= "00";
        wait for 10 ns;

        A <= x"FFFFFFFFFFFFFFFF";
        B <= x"FFFFFFFFFFFFFFFF";
        Size <= "00";
        wait for 10 ns;

        A <= x"F0F1F2F3F4F5F6F7";
        B <= x"0F0E0D0C0B0A0908";
        Size <= "00";
        wait for 10 ns;

        A <= x"8080808080808080";
        B <= x"7F7F7F7F7F7F7F7F";
        Size <= "00";
        wait for 10 ns;

        A <= x"0005000400030002";
        B <= x"0001000200010001";
        Size <= "01";
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"0001000200030004";
        Size <= "01";
        wait for 10 ns;

        A <= x"FFFFFFFFFFFFFFFF";
        B <= x"FFFFFFFFFFFFFFFF";
        Size <= "01";
        wait for 10 ns;

        A <= x"7fff7fff7fff7fff";
        B <= x"7fff7fff7fff7fff";
        Size <= "01";
        wait for 10 ns;

        A <= x"8000000080000000";
        B <= x"0001000100010001";
        Size <= "01";
        wait for 10 ns;

        A <= x"00F000AA00CC00FF";
        B <= x"000F0001000F0000";
        Size <= "01";
        wait for 10 ns;

        A <= x"0000000200000000";
        B <= x"0000000100000001";
        Size <= "10";
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"FFFFFFFFFFFFFFFF";
        Size <= "10";
        wait for 10 ns;

        A <= x"FFFFFFFFFFFFFFFF";
        B <= x"FFFFFFFFFFFFFFFF";
        Size <= "10";
        wait for 10 ns;

        A <= x"0000F0020000AA03";
        B <= x"0000000100000F01";
        Size <= "10";
        wait for 10 ns;

        A <= x"ffffffff80000000";
        B <= x"ffffffff7fffffff";
        Size <= "10";
        wait for 10 ns;

        A <= x"ffffffff0000aa02";
        B <= x"0000000100000f01";
        Size <= "10";
        wait for 10 ns;

        A <= x"ffffffff00000000";
        B <= x"0000000100000001";
        Size <= "10";
        wait for 10 ns;

        A <= x"0000000100000002";
        B <= x"0000000100000001";
        Size <= "10";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;