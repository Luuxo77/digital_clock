
library ieee;
use ieee.std_logic_1164.all;

entity seconds_counter is
    generic (
        CLOCK_FREQUENCY : natural := 100_000_000
    );
    port (
        clock : in std_logic;
        reset : in std_logic;
        hour_up : in std_logic;
        hour_down : in std_logic;
        minute_up : in std_logic;
        minute_down : in std_logic;
        seconds: out natural range 0 to 86_400
    ); 
end seconds_counter;

architecture behavioral of seconds_counter is

constant STOP_FREQUENCY : natural := CLOCK_FREQUENCY / 10;
signal can_change : std_logic := '1';
signal counter : natural range 0 to CLOCK_FREQUENCY - 1;
signal can_change_counter : natural range 0 to STOP_FREQUENCY - 1;
  
begin

seconds_counter : process (clock, reset) is

variable temp_seconds : natural range 0 to 86_400 := 0;

begin
    if reset = '1' then
        counter <= 0;
        temp_seconds := 0;
    elsif rising_edge(clock) then
        if (counter = CLOCK_FREQUENCY - 1) then
            temp_seconds := (temp_seconds + 1) mod 86_400;
            counter <= 0;
        else
            counter <= counter + 1;
            if(can_change = '0') then	
                 if (can_change_counter = STOP_FREQUENCY - 1) then
                     can_change <= '1';
                     can_change_counter <= 0;
                 else
                     can_change_counter <= can_change_counter + 1;
              end if;          
            elsif(can_change = '1' and 
            ( (hour_up or hour_down or minute_up or minute_down) = '1') ) then
                if(hour_up = '1') then
                    temp_seconds := (temp_seconds + 3_600) mod 86_400;
                elsif(hour_down = '1') then
                    temp_seconds := (temp_seconds - 3_600) mod 86_400;
                elsif(minute_up = '1') then
                    temp_seconds := (temp_seconds + 60) mod 86_400;
                elsif(minute_down = '1') then
                    temp_seconds := (temp_seconds - 60) mod 86_400;
                end if;
                can_change <= '0';
            end if;
        end if;
    end if;
    seconds <= temp_seconds;
    
end process;
  
end architecture behavioral;
