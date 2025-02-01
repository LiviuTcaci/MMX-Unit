library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Pentru tipuri semnate și operații numerice

entity Multiplier16bit is
    Port (
        A    : in  STD_LOGIC_VECTOR(15 downto 0);  -- Operand semnat pe 16 biți
        B    : in  STD_LOGIC_VECTOR(15 downto 0);  -- Operand semnat pe 16 biți
        Mode : in  STD_LOGIC;                      -- 0: PMULLW, 1: PMULHW
        Result : out STD_LOGIC_VECTOR(15 downto 0) -- Rezultatul final pe 16 biți
    );
end Multiplier16bit;

architecture Behavioral of Multiplier16bit is

    -- Componenta Multiplier8bit de 8 biți (semnat)
    component Multiplier8bit
        Port (
            A : in STD_LOGIC_VECTOR(7 downto 0);  -- Multiplicand (semnat, 8 biți)
            B : in STD_LOGIC_VECTOR(7 downto 0);  -- Multiplier (semnat, 8 biți)
            P : out STD_LOGIC_VECTOR(15 downto 0) -- Produs (semnat, 16 biți)
        );
    end component;

    -- Semnale interne
    signal Sign : STD_LOGIC;  -- Semnul rezultatului
    signal Abs_A, Abs_B : STD_LOGIC_VECTOR(15 downto 0);  -- Valorile absolute ale A și B
    signal A_high, A_low : STD_LOGIC_VECTOR(7 downto 0);  -- Partea superioară și inferioară a lui A
    signal B_high, B_low : STD_LOGIC_VECTOR(7 downto 0);  -- Partea superioară și inferioară a lui B
    signal LL, LH, HL, HH : STD_LOGIC_VECTOR(15 downto 0); -- Produsele parțiale

begin

    -- Determinarea semnului rezultatului
    Sign <= A(15) xor B(15);

    -- Calcularea valorilor absolute ale operandilor
    process(A, B)
    begin
        if A(15) = '1' then
            Abs_A <= std_logic_vector(-signed(A));
        else
            Abs_A <= A;
        end if;

        if B(15) = '1' then
            Abs_B <= std_logic_vector(-signed(B));
        else
            Abs_B <= B;
        end if;
    end process;

    -- Împărțirea valorilor absolute în părți de 8 biți
    A_low  <= Abs_A(7 downto 0);
    A_high <= Abs_A(15 downto 8);
    B_low  <= Abs_B(7 downto 0);
    B_high <= Abs_B(15 downto 8);

    -- Instanțierea componentelor Multiplier8bit
    LL_inst: Multiplier8bit
        port map (
            A => A_low,
            B => B_low,
            P => LL
        );

    LH_inst: Multiplier8bit
        port map (
            A => A_low,
            B => B_high,
            P => LH
        );

    HL_inst: Multiplier8bit
        port map (
            A => A_high,
            B => B_low,
            P => HL
        );

    HH_inst: Multiplier8bit
        port map (
            A => A_high,
            B => B_high,
            P => HH
        );

    -- Combinarea produselor parțiale și aplicarea semnului
    process(LL, LH, HL, HH, Sign, Mode)
        variable sum_part_signed : signed(31 downto 0);
        variable sum_part : unsigned(31 downto 0);
        variable LL_ext, LH_ext, HL_ext, HH_ext : unsigned(31 downto 0);
    begin
        -- Redimensionăm produsele parțiale la 32 de biți
        LL_ext := resize(unsigned(LL), 32);
        LH_ext := resize(unsigned(LH), 32);
        HL_ext := resize(unsigned(HL), 32);
        HH_ext := resize(unsigned(HH), 32);

        -- Combinăm produsele parțiale (produs final pe 32 biți):
        -- sum_part = LL + (LH << 8) + (HL << 8) + (HH << 16)
        sum_part := LL_ext + (LH_ext sll 8) + (HL_ext sll 8) + (HH_ext sll 16);

        -- Aplicăm semnul rezultatului
        if Sign = '1' then
            sum_part_signed := -signed(sum_part);
        else
            sum_part_signed := signed(sum_part);
        end if;

        -- Selector pentru PMULLW/PMULHW
        if Mode = '0' then
            -- PMULLW: partea joasă (lowest 16 bits)
            Result <= std_logic_vector(sum_part_signed(15 downto 0));
        else
            -- PMULHW: partea înaltă (highest 16 bits)
            Result <= std_logic_vector(sum_part_signed(31 downto 16));
        end if;
    end process;

end Behavioral;