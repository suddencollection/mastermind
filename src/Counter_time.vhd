library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_time is
port( R: in std_logic;
	  E: in std_logic;
	  clock: in std_logic;
	  ended: out std_logic;
	  count: out std_logic_vector(3 downto 0)
    );
end counter_time;

architecture circuito of counter_time is
signal valor: std_logic_vector(3 downto 0);
begin
    P1: process(clock, R)
    begin
        if R='1' then
            valor <= "1010"; -- De 10
            ended <= '0';
        elsif clock'event and clock= '1' then
			if E='1' then
                if valor = "0000" then -- Até 0
                    ended <= '1';
                else valor <= valor - 1;
                end if;
            end if;
        end if;
    end process;
    count <= valor;
end circuito;

