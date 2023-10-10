library ieee;
use ieee.std_logic_1164.all;

entity Wristwatch_tb is
end entity;

architecture tb of Wristwatch_tb is
   component Wristwatch is
      port (
         i_CLK     : in std_logic;
         i_RST     : in std_logic;
         i_B_n     : in std_logic;
         o_Display : out std_logic_vector(39 downto 0)
      );
   end component;
   signal w_CLK     : std_logic                     := '0';
   signal w_RST     : std_logic                     := '1';
   signal w_B_n     : std_logic                     := '1';
   signal w_Display : std_logic_vector(39 downto 0) := x"0000_00_0000";
begin
   u_Wristwatch : Wristwatch
   port map(
      i_CLK     => w_CLK,
      i_RST     => w_RST,
      i_B_n     => w_B_n,
      o_Display => w_Display
   );

   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   process
   begin
      wait for 1 ps;
      w_RST <= '0';
      wait for 4 ps;
      assert w_Display = x"31_39_3a_30_30" -- 19:00
      report "Error @ Displaying Hour"
         severity Error;
      w_B_n <= '0'; -- Button pressed
      wait for 8 ps;
      w_B_n <= '1'; -- Button released
      wait for 3 ps;
      assert w_Display = x"30_36_3a_30_30" -- 06:00
      report "Error @ Displaying Alarm"
         severity Error;
      w_B_n <= '0'; -- Button pressed
      wait for 8 ps;
      w_B_n <= '1'; -- Button released
      wait for 3 ps;
      assert w_Display = x"35_30_6d_69_6e" -- 5min
      report "Error @ Displaying Timer"
         severity Error;
      w_B_n <= '0'; -- Button pressed
      wait for 8 ps;
      w_B_n <= '1'; -- Button released
      wait for 3 ps;
      assert w_Display = x"31_36_2f_31_30" -- 16/10
      report "Error @ Displaying Date"
         severity Error;
      w_B_n <= '0'; -- Button pressed
      wait for 8 ps;
      w_B_n <= '1'; -- Button released
      wait for 3 ps;
      assert w_Display = x"31_39_3a_30_30" -- 19:00
      report "Error @ Displaying Hour (rollover)"
         severity Error;
      wait;
   end process;
end architecture;