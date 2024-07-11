library IEEE;
use IEEE.Std_Logic_1164.all;

entity decodtermo is
port (X: in  std_logic_vector(3 downto 0);
		S: out std_logic_vector(15 downto 0));
end decodtermo;

architecture Dec_arch of decodtermo is
begin
S <= "0000000000000000" when X = "0000" else 
		 "0000000000000001" when X = "0001" else 
		 "0000000000000011" when X = "0010" else 
		 "0000000000000111" when X = "0011" else 
		 "0000000000001111" when X = "0100" else 
		 "0000000000011111" when X = "0101" else 
		 "0000000000111111" when X = "0110" else 
		 "0000000001111111" when X = "0111" else 
		 "0000000011111111" when X = "1000" else 
		 "0000000111111111" when X = "1001" else 
		 "0000001111111111" when X = "1010" else 
		 "0000011111111111" when X = "1011" else 
		 "0000111111111111" when X = "1100" else 
		 "0001111111111111" when X = "1101" else 
		 "0011111111111111" when X = "1110" else 
		 "0111111111111111";
end Dec_arch;

