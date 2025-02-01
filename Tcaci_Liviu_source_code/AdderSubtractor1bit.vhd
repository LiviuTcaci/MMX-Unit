library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AdderSubtractor1bit is
  Port (
    A       : in  STD_LOGIC;  -- Operand A
    B       : in  STD_LOGIC;  -- Operand B
    Cin     : in  STD_LOGIC;  -- Carry-in / Borrow-in
    Op      : in  STD_LOGIC;  -- 0: Adder, 1: Subtractor
    Result  : out STD_LOGIC;  -- Sum / Difference
    Cout    : out STD_LOGIC   -- Carry-out / Borrow-out
  );
end AdderSubtractor1bit;

architecture Behavioral of AdderSubtractor1bit is
  signal Carry : STD_LOGIC;  -- Carry-out pentru adunare
  signal Borrow : STD_LOGIC; -- Borrow-out pentru scădere
begin

  -- Calculul rezultatului
  Result <= A XOR B XOR Cin;

  -- Calculul Carry-out și Borrow-out
  Carry <= (A and B) or (B and Cin) or (Cin and A); -- Carry-out pentru adunare
  Borrow <= (NOT A AND B) OR (B AND Cin) OR (Cin AND NOT A); -- Borrow-out pentru scădere

  -- Selectăm Cout în funcție de operație
  Cout <= Carry when Op = '0' else Borrow;
end Behavioral;