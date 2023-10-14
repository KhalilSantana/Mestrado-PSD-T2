library ieee;
use ieee.std_logic_1164.all;

entity Controller is
   port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_B_n : in std_logic;
      o_S0  : out std_logic;
      o_S1  : out std_logic
   );
end entity;

architecture moore_arch of Controller is
   type state is (
      S0_Hour, S0_Hour_wait,
      S1_Alarm, S1_Alarm_wait,
      S2_Timer, S2_Timer_wait,
      S3_Date, S3_Date_wait
   );
   signal current_state, next_state : state;
begin
   process (i_CLK, i_RST)
   begin
      if i_RST = '1' then
         current_state <= S0_Hour;
      elsif rising_edge(i_CLK) then
         current_state <= next_state;
      end if;
   end process;
   process (current_state, i_B_n)
   begin
      case current_state is
            -- ===========
            -- == Hour ==
            -- ===========
         when S0_Hour =>
            if i_B_n = '0' then
               next_state <= S0_Hour_wait;
            else
               next_state <= S0_Hour;
            end if;
         when S0_Hour_wait =>
            if i_B_n = '1' then
               next_state <= S1_Alarm;
            else
               next_state <= S0_Hour_wait;
            end if;
            -- ===========
            -- == ALARM ==
            -- ===========
         when S1_Alarm =>
            if i_B_n = '0' then
               next_state <= S1_Alarm_wait;
            else
               next_state <= S1_Alarm;
            end if;
         when S1_Alarm_wait =>
            if i_B_n = '1' then
               next_state <= S2_Timer;
            else
               next_state <= S1_Alarm_wait;
            end if;
            -- ===========
            -- == Timer ==
            -- ===========
         when S2_Timer =>
            if i_B_n = '0' then
               next_state <= S2_Timer_wait;
            else
               next_state <= S2_Timer;
            end if;
         when S2_Timer_wait =>
            if i_B_n = '1' then
               next_state <= S3_Date;
            else
               next_state <= S2_Timer_wait;
            end if;
            -- ===========
            -- == Date ==
            -- ===========
         when S3_Date =>
            if i_B_n = '0' then
               next_state <= S3_Date_wait;
            else
               next_state <= S3_Date;
            end if;
         when S3_Date_wait =>
            if i_B_n = '1' then
               next_state <= S0_Hour;
            else
               next_state <= S3_Date_wait;
            end if;
         when others =>
            next_state <= S0_Hour;
      end case;
   end process;
   o_S0 <=
      '0' when current_state = S0_Hour else
      '0' when current_state = S0_Hour_wait else
      '0' when current_state = S2_Timer else
      '0' when current_state = S2_Timer_wait else
      '1' when current_state = S1_Alarm else
      '1' when current_state = S1_Alarm_wait else
      '1' when current_state = S3_Date else
      '1' when current_state = S3_Date_wait;
   o_S1 <=
      '0' when current_state = S0_Hour else
      '0' when current_state = S0_Hour_wait else
      '0' when current_state = S1_Alarm else
      '0' when current_state = S1_Alarm_wait else
      '1' when current_state = S2_Timer else
      '1' when current_state = S2_Timer_wait else
      '1' when current_state = S3_Date else
      '1' when current_state = S3_Date_wait;
end architecture;
