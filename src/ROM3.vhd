library ieee;
use ieee.std_logic_1164.all;

entity ROM3 is port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end ROM3;

architecture Rom_Arch of ROM3 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

    00 => "0001001001100010",  --1262   
    01 => "0011000010010010",  --3092 
    02 => "0100001000010111",  --4217
    03 => "0100001000111001",  --4239
    04 => "0011100100100111",  --3927
    05 => "0011000010011000",  --3098
    06 => "0000001000110111",  --0237
    07 => "0001010100100011",  --1523
    08 => "0100011010010101",  --4695
    09 => "0111100101010100",  --7954
    10 => "0111100000001001",  --7809
    11 => "0011010100010100",  --3514
    12 => "1000011100010110",  --8716
    13 => "1000000110010011",  --8193
    14 => "1001010001010110",  --9456
    15 => "0111100110000001"); --7981
	
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
