library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity test_env is
    Port (
        clk : in STD_LOGIC;                        -- Semnalul de ceas
        btn : in STD_LOGIC_VECTOR(4 downto 0);     -- Butoanele de control (up, down, center)
        sw : in STD_LOGIC_VECTOR(15 downto 0);     -- Comutatoare (pentru operație și selecție lower/upper bits)
        led : out STD_LOGIC_VECTOR(15 downto 0);   -- LED-uri pentru ieșire (index, control operație, select bits)
        an : out STD_LOGIC_VECTOR(7 downto 0);     -- Anod 7-segmente
        cat : out STD_LOGIC_VECTOR(6 downto 0)     -- Catod 7-segmente
    );
end test_env;

architecture Behavioral of test_env is

    -- Semnale interne
    signal BtnUp_enable, BtnDown_enable, BtnCenter_enable : STD_LOGIC; -- Ieșirile MPG pentru debounce
    signal A, B : STD_LOGIC_VECTOR(63 downto 0);                      -- Vectorii A și B
    signal index_out : STD_LOGIC_VECTOR(9 downto 0);                 -- Indexul curent din memorie
    signal Result : STD_LOGIC_VECTOR(63 downto 0);                    -- Rezultatul din MMX_Unit
    signal SelectedBits : STD_LOGIC_VECTOR(31 downto 0);              -- Biții selectați (lower/upper)
    signal IndicatorLED : STD_LOGIC;                                  -- LED pentru selecția lower/upper bits
    signal OpCode : STD_LOGIC_VECTOR(2 downto 0);
    signal Size : STD_LOGIC_VECTOR(1 downto 0);
    -- Componente declarate
    component MPG is
        Port (
            enable : out STD_LOGIC;
            btn    : in  STD_LOGIC;
            clk    : in  STD_LOGIC
        );
    end component;

    component MemoryUnit is
        Port (
            clk      : in  STD_LOGIC;
            BtnUp    : in  STD_LOGIC;
            BtnDown  : in  STD_LOGIC;
            BtnCenter: in  STD_LOGIC;
            A        : out STD_LOGIC_VECTOR(63 downto 0);
            B        : out STD_LOGIC_VECTOR(63 downto 0);
            index_out: out STD_LOGIC_VECTOR(9 downto 0)
        );
    end component;

    component MMX_Unit is
        Port (
            A       : in  STD_LOGIC_VECTOR(63 downto 0);
            B       : in  STD_LOGIC_VECTOR(63 downto 0);
            Control : in  STD_LOGIC_VECTOR(2 downto 0);
            Size    : in  STD_LOGIC_VECTOR(1 downto 0);
            Result  : out STD_LOGIC_VECTOR(63 downto 0)
        );
    end component;

    component BitSelector is
        Port (
            Result       : in  STD_LOGIC_VECTOR(63 downto 0);
            SelectBit    : in  STD_LOGIC;
            SelectedBits : out STD_LOGIC_VECTOR(31 downto 0);
            IndicatorLED : out STD_LOGIC
        );
    end component;

    component SSD is
        Port (
            clk    : in  STD_LOGIC;
            digits : in  STD_LOGIC_VECTOR(31 downto 0);
            an     : out STD_LOGIC_VECTOR(7 downto 0);
            cat    : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

begin
    OpCode <= sw(2 downto 0);
    Size <= sw(4 downto 3);

    -- Instanțierea componentelor MPG pentru debounce
    MPG_Up: MPG port map(enable => BtnUp_enable, btn => btn(1), clk => clk);
    MPG_Down: MPG port map(enable => BtnDown_enable, btn => btn(4), clk => clk);
    MPG_Center: MPG port map(enable => BtnCenter_enable, btn => btn(0), clk => clk);

    -- Instanțierea MemoryUnit
    Memory: MemoryUnit
        port map(
            clk       => clk,
            BtnUp     => BtnUp_enable,
            BtnDown   => BtnDown_enable,
            BtnCenter => BtnCenter_enable,
            A         => A,
            B         => B,
            index_out => index_out
        );

    -- Instanțierea MMX_Unit
    MMX: MMX_Unit
        port map(
            A       => A,
            B       => B,
            Control => OpCode,
            Size    => Size,
            Result  => Result
        );

    -- Instanțierea BitSelector
    Selector: BitSelector
        port map(
            Result       => Result,
            SelectBit    => sw(15),
            SelectedBits => SelectedBits,
            IndicatorLED => IndicatorLED
        );

    -- Instanțierea SSD
    SSD_Display: SSD
        port map(
            clk    => clk,
            digits => SelectedBits,
            an     => an,
            cat    => cat
        );

    -- Maparea LED-urilor
    led(14 downto 5) <= index_out;        -- Poziția curentă din memorie
    led(4 downto 3) <= Size;               -- Dimensiunea operației
    led(2 downto 0) <= OpCode;            -- Operația selectată
    led(15) <= IndicatorLED;               -- Starea selectorului lower/upper bits

end Behavioral;
