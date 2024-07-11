library IEEE;
use IEEE.Std_Logic_1164.all;

entity multiplexador16 is
port (F1: in  std_logic_vector(15 downto 0);
		F2: in  std_logic_vector(15 downto 0);
		F3: in  std_logic_vector(15 downto 0);
		F4: in  std_logic_vector(15 downto 0);
		sel: in  std_logic_vector(1 downto 0);
		F: out  std_logic_vector(15 downto 0));
end multiplexador16;

architecture Mux_arch of multiplexador16 is
begin
	F <= 	F1 when sel = "00" else 
				F2 when sel = "01" else
				F3 when sel = "10" else 
				F4; 
end Mux_arch;
