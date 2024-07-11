library ieee;
use ieee.std_logic_1164.all;
--use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity comp_n is 
port(c, u: in  std_logic_vector(3 downto 0);
     P0: out std_logic);
end comp_n;

architecture arc_comp of comp_n is
begin

P0 <= '1' when c = u else '0';

end arc_comp;

