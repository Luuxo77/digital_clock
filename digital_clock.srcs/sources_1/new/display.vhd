
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
    port 
    (
        clock : in  std_logic;
        hours_first_digit_seg : in std_logic_vector(0 TO 6);
        hours_second_digit_seg : in std_logic_vector(0 TO 6);
        minutes_first_digit_seg : in std_logic_vector(0 TO 6);
        minutes_second_digit_seg: in std_logic_vector(0 TO 6);		
        anode : out std_logic_vector(0 TO 3);
        segments : out std_logic_vector(0 TO 6)
    );				
end display;
         
architecture behavioral of display is

signal count1 : integer := 0;
signal selector : integer range 0 to 3 := 0;

begin

anode_clock : process(count1, clock, selector)
begin
    if (rising_edge(clock)) then
        count1 <= count1 + 1;
        if (count1 = 249999) then
            selector <= selector + 1;
            count1 <= 0;
        end if;
    end if;
end process;

anode_display : process(selector) begin
    case selector is
        when 0 =>
            anode <= "1110";
            segments <= minutes_second_digit_seg;
        when 1 => 
            anode <= "1101";
            segments <= minutes_first_digit_seg;
        when 2 =>
            anode <= "1011";
            segments <= hours_second_digit_seg;
        when 3 =>
            anode <= "0111";
            segments <= hours_first_digit_seg;
        end case;
end process;        

end behavioral;
