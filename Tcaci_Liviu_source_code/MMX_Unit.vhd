library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MMX_Unit is
    Port (
        A       : in  STD_LOGIC_VECTOR(63 downto 0);  -- Operand A
        B       : in  STD_LOGIC_VECTOR(63 downto 0);  -- Operand B
        Control : in  STD_LOGIC_VECTOR(2 downto 0);   -- Semnal de selecție (pentru operații)
        Size    : in  STD_LOGIC_VECTOR(1 downto 0);   -- Dimensiunea operațiilor: 00 = 8 biți, 01 = 16 biți, 10 = 32 biți
        Result  : out STD_LOGIC_VECTOR(63 downto 0)   -- Rezultatul final
    );
end MMX_Unit;

architecture Behavioral of MMX_Unit is
    -- Declararea componentelor
    component PADD
        Port ( A : in  STD_LOGIC_VECTOR(63 downto 0);
               B : in  STD_LOGIC_VECTOR(63 downto 0);
               Size : in STD_LOGIC_VECTOR(1 downto 0);
               Result : out STD_LOGIC_VECTOR(63 downto 0));
    end component;

    component PADDS
        Port ( A : in  STD_LOGIC_VECTOR(63 downto 0);
               B : in  STD_LOGIC_VECTOR(63 downto 0);
               Size : in STD_LOGIC;
               Result : out STD_LOGIC_VECTOR(63 downto 0));
    end component;

    component PADDUS
        Port ( A : in  STD_LOGIC_VECTOR(63 downto 0);
               B : in  STD_LOGIC_VECTOR(63 downto 0);
               Size : in STD_LOGIC;
               Result : out STD_LOGIC_VECTOR(63 downto 0));
    end component;

    component PSUB
        Port ( A : in  STD_LOGIC_VECTOR(63 downto 0);
               B : in  STD_LOGIC_VECTOR(63 downto 0);
               Size : in STD_LOGIC_VECTOR(1 downto 0);
               Result : out STD_LOGIC_VECTOR(63 downto 0));
    end component;

    component PSUBS
        Port ( A : in  STD_LOGIC_VECTOR(63 downto 0);
               B : in  STD_LOGIC_VECTOR(63 downto 0);
               Size : in STD_LOGIC;
               Result : out STD_LOGIC_VECTOR(63 downto 0));
    end component;

    component PMUL
        Port ( A : in  STD_LOGIC_VECTOR(63 downto 0);
               B : in  STD_LOGIC_VECTOR(63 downto 0);
               Mode : in STD_LOGIC; -- 0: PMULLW, 1: PMULHW
               Result : out STD_LOGIC_VECTOR(63 downto 0));
    end component;

    -- Semnale intermediare
    signal padd_result, padds_result, paddus_result : STD_LOGIC_VECTOR(63 downto 0);
    signal psub_result, psubs_result : STD_LOGIC_VECTOR(63 downto 0);
    signal pmullw_result, pmulhw_result : STD_LOGIC_VECTOR(63 downto 0);

begin
    -- Instanțierea componentelor
    U_PADD: PADD port map(A => A, B => B, Size => Size, Result => padd_result);
    U_PADDS: PADDS port map(A => A, B => B, Size => Size(0), Result => padds_result);
    U_PADDUS: PADDUS port map(A => A, B => B, Size => Size(0), Result => paddus_result);
    U_PSUB: PSUB port map(A => A, B => B, Size => Size, Result => psub_result);
    U_PSUBS: PSUBS port map(A => A, B => B, Size => Size(0), Result => psubs_result);
    U_PMULLW: PMUL port map(A => A, B => B, Mode => '0', Result => pmullw_result);
    U_PMULHW: PMUL port map(A => A, B => B, Mode => '1', Result => pmulhw_result);

    -- Selectarea rezultatului pe baza semnalului Control
    with Control select
        Result <= padd_result    when "000", -- PADD
        padds_result   when "001", -- PADDS
        paddus_result  when "010", -- PADDUS
        psub_result    when "011", -- PSUB
        psubs_result   when "100", -- PSUBS
        pmullw_result  when "101", -- PMULLW
        pmulhw_result  when "110", -- PMULHW
        (others => '0') when others; -- Default: 0

end Behavioral;