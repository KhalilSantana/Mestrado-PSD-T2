library ieee;
use ieee.std_logic_1164.all;

entity Wristwatch is
   port (
      i_CLK     : in std_logic;
      i_RST     : in std_logic;
      i_B_n     : in std_logic;
      i_Hour    : in std_logic_vector(39 downto 0);
      i_Alarm   : in std_logic_vector(39 downto 0);
      i_Timer   : in std_logic_vector(39 downto 0);
      i_Date    : in std_logic_vector(39 downto 0);
      o_Display : out std_logic_vector(39 downto 0)
   );
end entity;

architecture rtl of Wristwatch is
   signal w_S     : std_logic_vector(1 downto 0)  := "00";
   component Controller is
      port (
         i_CLK : in std_logic;
         i_RST : in std_logic;
         i_B_n : in std_logic;
         o_S0  : out std_logic;
         o_S1  : out std_logic
      );
   end component;
   component Datapath is
      port (
         --   i_S0      : in std_logic;
         i_S       : in std_logic_vector(1 downto 0);
         i_Hour    : in std_logic_vector(39 downto 0);
         i_Alarm   : in std_logic_vector(39 downto 0);
         i_Timer   : in std_logic_vector(39 downto 0);
         i_Date    : in std_logic_vector(39 downto 0);
         o_Display : out std_logic_vector(39 downto 0)
      );
   end component;
begin
   u_Controller : Controller
   port map(
      i_CLK => i_CLK,
      i_RST => i_RST,
      i_B_n => i_B_n,
      o_S0  => w_S(0),
      o_S1  => w_S(1)
   );
   u_Datapath : Datapath port map(
      i_S       => w_S,
      i_Hour    => i_Hour,
      i_Alarm   => i_Alarm,
      i_Timer   => i_Timer,
      i_Date    => i_Date,
      o_Display => o_Display
   );
end architecture;