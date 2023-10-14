library ieee;
use ieee.std_logic_1164.all;

entity Datapath is
   port (
      --   i_S0      : in std_logic;
      i_S       : in std_logic_vector(1 downto 0);
      i_Hour    : in std_logic_vector(39 downto 0);
      i_Alarm   : in std_logic_vector(39 downto 0);
      i_Timer   : in std_logic_vector(39 downto 0);
      i_Date    : in std_logic_vector(39 downto 0);
      o_Display : out std_logic_vector(39 downto 0)
   );
end entity;

architecture rtl of Datapath is
begin
   process (i_Hour, i_Alarm, i_Timer, i_Date, i_S)
   begin
      case i_S is
         when "00" =>
            o_Display <= i_Hour;
         when "01" =>
            o_Display <= i_Alarm;
         when "10" =>
            o_Display <= i_Timer;
         when "11" =>
            o_Display <= i_Date;
         when others          =>
            o_Display <= (others => '0'); -- Default case
      end case;
   end process;
end architecture;