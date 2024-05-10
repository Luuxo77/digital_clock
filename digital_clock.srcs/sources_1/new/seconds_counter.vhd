
library ieee;
use ieee.std_logic_1164.all;

entity seconds_counter is
    generic 
    (
        CLOCK_FREQUENCY : natural := 100_000_000
    );
    port 
    (
        clock : in std_logic;
        reset : in std_logic;
        seconds: out natural range 0 to 86_400
    ); 
end seconds_counter;

architecture behavioural of seconds_counter is

  signal counter : natural range 0 to CLOCK_FREQUENCY - 1;
  signal temp_seconds : natural range 0 to 86_400 := 0;
  
begin

  process (clock, reset) is
  begin
    if reset = '1' then
        counter <= 0;
        temp_seconds <= 0;   
    elsif rising_edge(clock) then		
        if (counter = CLOCK_FREQUENCY - 1) then
            temp_seconds <= (temp_seconds + 1) mod 86_400;
            counter <= 0;
        else
            counter <= counter + 1;
        end if;					
    end if;
  end process;
  
  seconds <= temp_seconds;
  
end architecture behavioural;