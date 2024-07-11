library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter_round is
port(R: in std_logic;
	 E: in std_logic;
	 clock: in std_logic;
	 end_round: out std_logic;
     X: out std_logic_vector(3 downto 0)
);
end counter_round;

architecture circuito of counter_round is
signal valor: std_logic_vector(3 downto 0);
begin
    P1: process(clock, R)
    begin
        if R='1' then
            valor <= "0000";
            end_round <= '0';
        elsif clock'event and clock= '1' then
			if E='1' then
                if valor = "1111" then -- Até 15
                    valor <= "0000";
                    end_round <= '1';
                else valor <= valor + 1;
                end if;
            end if;
        end if;
    end process;
    X <= valor;
end circuito;

