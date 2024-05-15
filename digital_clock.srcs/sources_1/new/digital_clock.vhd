
library ieee;
use ieee.std_logic_1164.all;

entity digital_clock is
    port (
        clk : in  std_logic;
        btnC : in std_logic;
        btnU : in std_logic;
        btnD : in std_logic;
        btnL : in std_logic;
        btnR : in std_logic;	
        an : out std_logic_vector(0 TO 3);
        seg : out std_logic_vector(0 TO 6)
    ); 					
end digital_clock;
         
architecture behavioral of digital_clock is

signal seconds: natural range 0 to 86_400;
signal hours_first:  std_logic_vector(0 TO 6);
signal hours_second:  std_logic_vector(0 TO 6);
signal minutes_first:  std_logic_vector(0 TO 6);
signal minutes_second:  std_logic_vector(0 TO 6);

begin

sec_cnt : entity work.seconds_counter
port map (
    clock => clk,
    reset => btnC,
    hour_up => btnU,
    hour_down => btnD,
    minute_up => btnR,
    minute_down => btnL,
    seconds => seconds
);

seg_cnv : entity work.segments_converter
port map(
    seconds => seconds,
    hours_first_digit_seg => hours_first,
    hours_second_digit_seg => hours_second,
    minutes_first_digit_seg => minutes_first,
    minutes_second_digit_seg => minutes_second
);

disp : entity work.display
port map(
    clock => clk,
    hours_first_digit_seg => hours_first,
    hours_second_digit_seg => hours_second,
    minutes_first_digit_seg => minutes_first,
    minutes_second_digit_seg => minutes_second,
    anode => an,
    segments => seg
);

end behavioral;
