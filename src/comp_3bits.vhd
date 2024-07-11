library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity comp_3bits is 
port(A, B: in  std_logic_vector(2 downto 0);
     R: out std_logic);
end comp_3bits;

architecture arc_comp of comp_3bits is
begin

R <= '1' when A = B else '0';

end arc_comp;

