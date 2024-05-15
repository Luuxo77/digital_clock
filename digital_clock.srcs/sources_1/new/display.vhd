
library ieee;
use ieee.std_logic_1164.all;

entity display is
    generic (
        CLOCK_FREQUENCY : natural := 100_000_000
    );
    port (
        clock : in std_logic;
        hours_first_digit_seg : in std_logic_vector(0 TO 6);
        hours_second_digit_seg : in std_logic_vector(0 TO 6);
        minutes_first_digit_seg : in std_logic_vector(0 TO 6);
        minutes_second_digit_seg: in std_logic_vector(0 TO 6);		
        anode : out std_logic_vector(0 TO 3);
        segments : out std_logic_vector(0 TO 6)
    );
end display;
         
architecture behavioral of display is

constant REFRESH_FREQUENCY : natural := CLOCK_FREQUENCY / 400;
signal counter : natural range 0 to REFRESH_FREQUENCY - 1 := 0;
signal selector : natural range 0 to 3 := 0;

begin

anode_clock : process (clock) is
begin

    if rising_edge(clock) then
        if (counter = REFRESH_FREQUENCY - 1) then
            selector <= (selector + 1) mod 4;
            counter <= 0;
        else
            counter <= counter + 1;
        end if;
    end if;
    
end process;

anode_display : process (selector) is
begin

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
