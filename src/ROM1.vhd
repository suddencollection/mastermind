library ieee;
use ieee.std_logic_1164.all;

entity ROM1 is port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end ROM1;

architecture Rom_Arch of ROM1 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

    00 => "0101010000110010",  --5432  
    01 => "0100001100100001",  --4321   
    02 => "0010001101000101",  --2345
    03 => "0100001100010000",  --4310
    04 => "0100001100010010",  --4312
    05 => "0001001101010010",  --1352
    06 => "0100001101010001",  --4351
    07 => "0100001100010101",  --4315
    08 => "0001001100000101",  --1305
    09 => "0101000000110010",  --5032
    10 => "0100001100100000",  --4320
    11 => "0000001100010010",  --0312
    12 => "0011001000000001",  --3201
    13 => "0000000100100011",  --0123
    14 => "0101000100000100",  --5104
    15 => "0010001101000000"); --2340
	 
	
begin
   process (address)
   begin
       case address is
       when "0000" => data <= my_rom(00);
       when "0001" => data <= my_rom(01);
       when "0010" => data <= my_rom(02);
       when "0011" => data <= my_rom(03);
       when "0100" => data <= my_rom(04);
       when "0101" => data <= my_rom(05);
       when "0110" => data <= my_rom(06);
       when "0111" => data <= my_rom(07);
       when "1000" => data <= my_rom(08);
       when "1001" => data <= my_rom(09);
	   when "1010" => data <= my_rom(10);
	   when "1011" => data <= my_rom(11);
       when "1100" => data <= my_rom(12);
	   when "1101" => data <= my_rom(13);
	   when "1110" => data <= my_rom(14);
	   when others => data <= my_rom(15);
     end case;
  end process;
end architecture Rom_Arch;
