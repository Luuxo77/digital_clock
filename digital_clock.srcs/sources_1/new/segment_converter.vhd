
library ieee;
use ieee.std_logic_1164.all;

entity segments_converter is
    port (
        seconds : in natural range 0 to 86_400;
        hours_first_digit_seg : out std_logic_vector(0 TO 6);
        hours_second_digit_seg : out std_logic_vector(0 TO 6);
        minutes_first_digit_seg : out std_logic_vector(0 TO 6);
        minutes_second_digit_seg: out std_logic_vector(0 TO 6) 
    );
end segments_converter;

architecture behavioral of segments_converter is

  signal hours : natural range 0 to 23;
  signal minutes : natural range 0 to 59;
  signal hours_first_digit : natural range 0 to 2;
  signal hours_second_digit : natural range 0 to 9;
  signal minutes_first_digit : natural range 0 to 5;
  signal minutes_second_digit : natural range 0 to 9;
  
function to_segments(digit : natural) return std_logic_vector is
begin

    case digit is
        when 0 => return "0000001";
        when 1 => return "1001111";
        when 2 => return "0010010";
        when 3 => return "0000110";
        when 4 => return "1001100";
        when 5 => return "0100100";
        when 6 => return "0100000";
        when 7 => return "0001111";
        when 8 => return "0000000";
        when 9 => return "0000100";
        when others => return "1111111";
    end case;
    
end to_segments;

begin						

  hours <= seconds / 3_600;
  hours_first_digit <= hours / 10;
  hours_second_digit <= hours mod 10;
  
  minutes <= (seconds mod 3_600) / 60;
  minutes_first_digit <= minutes / 10;
  minutes_second_digit <= minutes mod 10;
  
  hours_first_digit_seg <= to_segments(hours_first_digit);
  hours_second_digit_seg <= to_segments(hours_second_digit);
  minutes_first_digit_seg <= to_segments(minutes_first_digit);
  minutes_second_digit_seg <= to_segments(minutes_second_digit);
  
end architecture behavioral;
