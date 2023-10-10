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
   o_Display <=
      i_Hour when i_S = "00" else
      i_Alarm when i_S = "01" else
      i_Timer when i_S = "10" else
      i_Date when i_S = "11" else
      i_Hour;
end architecture;