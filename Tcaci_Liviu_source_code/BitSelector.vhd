library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BitSelector is
    Port (
        Result       : in  STD_LOGIC_VECTOR(63 downto 0); -- Rezultatul pe 64 de biți
        SelectBit    : in  STD_LOGIC;                    -- Semnal de selecție (sw[15])
        SelectedBits : out STD_LOGIC_VECTOR(31 downto 0); -- Biții selectați (lower/upper)
        IndicatorLED : out STD_LOGIC                     -- LED de indicator pentru SelectBit
    );
end BitSelector;

architecture Behavioral of BitSelector is
begin
    -- Selectăm partea relevantă a vectorului în funcție de SelectBit
    SelectedBits <= Result(31 downto 0) when SelectBit = '0' else Result(63 downto 32);

    -- Indicăm starea lui SelectBit pe LED
    IndicatorLED <= SelectBit;
end Behavioral;
