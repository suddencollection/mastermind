library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; -- necessário para o +

entity somadormaior is
port(A, B, C, D: in std_logic;
	   F: out  std_logic_vector(2 downto 0));
end somadormaior;

architecture arch_Som of somadormaior is
signal a_s, b_s, c_s, d_s: std_logic_vector(2 downto 0);
begin

a_s <= '0' & '0' & A;
b_s <= '0' & '0' & B;
c_s <= '0' & '0' & C;
d_s <= '0' & '0' & D;

F <= a_s + b_s + c_s + d_s;

end arch_Som;
