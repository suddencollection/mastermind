library ieee;
use ieee.std_logic_1164.all;

entity ROM2 is port (
    address : in  std_logic_vector(3 downto 0);
    data    : out std_logic_vector(15 downto 0));
end ROM2;

architecture Rom_Arch of ROM2 is

type memory is array (00 to 15) of std_logic_vector(15 downto 0);
constant my_Rom : memory := (

    00 => "0110010100000100",  --6504  
    01 => "0100000000010101",  --4015
    02 => "0100001100010110",  --4316
    03 => "0100010100100000",  --4520
    04 => "0110000000010111",  --6017
    05 => "0100011100110010",  --4732
    06 => "0011011100010110",  --3716
    07 => "0010000001010111",  --2057
    08 => "0111011000010010",  --7612
    09 => "0101011101100011",  --5763
    10 => "0100011000010010",  --4612
    11 => "0111001000010101",  --7215
    12 => "0010010100110110",  --2536
    13 => "0011010000010000",  --3410
    14 => "0111010100010110",  --7516
    15 => "0111001100010010"); --7312 
	 
	
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
