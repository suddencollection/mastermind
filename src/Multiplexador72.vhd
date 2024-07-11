library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplexador72 is
port (F1: in  std_logic_vector(6 downto 0);
			F2: in  std_logic_vector(6 downto 0);
			sel: in  std_logic;
			F: out  std_logic_vector(6 downto 0));
end multiplexador72;

architecture Mux_arch of multiplexador72 is
begin
	F <= 	F1 when sel = '0' else 
				F2; 
end Mux_arch;
