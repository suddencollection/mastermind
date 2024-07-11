library ieee;
use ieee.std_logic_1164.all;

entity registrador3 is
port (CLK, RST, EN: in std_logic; 
D: in std_logic_vector(2 downto 0); 
Q: out std_logic_vector(2 downto 0)
);
end registrador3;

architecture arch_Reg of registrador3 is
begin
process(CLK, D, EN, RST)
begin

if RST = '1' then Q <= "000";
elsif (CLK'event and CLK = '1') then
    if EN = '1' then  Q <= D;
    end if;
end if;

end process;
end arch_Reg;
