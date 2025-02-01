library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PMUL_TB is
end PMUL_TB;

architecture Behavioral of PMUL_TB is
    -- Semnale pentru input-uri si output-uri
    signal A, B : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal Mode : STD_LOGIC; -- 0: PMULLW (low), 1: PMULHW (high)
    signal Result : STD_LOGIC_VECTOR(63 downto 0);

    -- Unit Under Test (UUT)
    component PMUL
        Port (
            A    : in  STD_LOGIC_VECTOR(63 downto 0);
            B    : in  STD_LOGIC_VECTOR(63 downto 0);
            Mode : in  STD_LOGIC;
            Result : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

begin
    -- Instanteaza PMUL
    UUT: PMUL port map(
        A => A,
        B => B,
        Mode => Mode,
        Result => Result
    );

    -- Proces de generare a testelor
    stim_proc: process
    begin
        -- ===== Teste pentru PMUL (16-bit) =====

        A <= x"0001000100010001";
        B <= x"0001000100010001";
        Mode <= '0';
        wait for 10 ns;

        A <= x"0001000100010001";
        B <= x"0001000100010001";
        Mode <= '1';
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"0001000200030004";
        Mode <= '0';
        wait for 10 ns;

        A <= x"0000000000000000";
        B <= x"0001000200030004";
        Mode <= '1';
        wait for 10 ns;

        A <= x"7FFF7FFF7FFF7FFF";
        B <= x"0001000100010001";
        Mode <= '0';
        wait for 10 ns;

        A <= x"7FFF7FFF7FFF7FFF";
        B <= x"0001000100010001";
        Mode <= '1';
        wait for 10 ns;

        A <= x"7FFF7FFF7FFF7FFF";
        B <= x"7FFF7FFF7FFF7FFF";
        Mode <= '0';
        wait for 10 ns;

        A <= x"7FFF7FFF7FFF7FFF";
        B <= x"7FFF7FFF7FFF7FFF";
        Mode <= '1';
        wait for 10 ns;

        A <= x"8000800080008000";
        B <= x"0001000100010001";
        Mode <= '0';
        wait for 10 ns;

        A <= x"8000800080008000";
        B <= x"0001000100010001";
        Mode <= '1';
        wait for 10 ns;

        A <= x"ffff0000ffff0000";
        B <= x"0001000100010001";
        Mode <= '0';
        wait for 10 ns;

        A <= x"ffff0000ffff0000";
        B <= x"0001000100010001";
        Mode <= '1';
        wait for 10 ns;

        A <= x"7fff80007fff8000";
        B <= x"7fff80007fff8000";
        Mode <= '0';
        wait for 10 ns;

        A <= x"7fff80007fff8000";
        B <= x"7fff80007fff8000";
        Mode <= '1';
        wait for 10 ns;

        A <= x"0000f0020000aa03";
        B <= x"0000000100000f01";
        Mode <= '0';
        wait for 10 ns;

        A <= x"0000f0020000aa03";
        B <= x"0000000100000f01";
        Mode <= '1';
        wait for 10 ns;

        A <= x"ffffffff80000000";
        B <= x"ffffffff7fffffff";
        Mode <= '0';
        wait for 10 ns;

        A <= x"ffffffff80000000";
        B <= x"ffffffff7fffffff";
        Mode <= '1';
        wait for 10 ns;
        wait;
    end process;

end Behavioral;