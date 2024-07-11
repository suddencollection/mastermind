library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity comp_4bits is 
port(A, B: in  std_logic_vector(3 downto 0);
     R: out std_logic);
end comp_4bits;

architecture arc_comp of comp_4bits is
begin

R <= '1' when A = B else '0';

end arc_comp;

