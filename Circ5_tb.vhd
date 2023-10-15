library ieee;
use ieee.std_logic_1164.all;

entity Circ5_tb is
end entity;

architecture tb of Circ5_tb is
   component Circ5 is
      port (
         i_CLK : in std_logic;
         i_RST : in std_logic;
         i_A   : in std_logic;
         i_B   : in std_logic;
         o_Y   : out std_logic
      );
   end component;
   signal w_CLK : std_logic := '0';
   signal w_RST : std_logic := '0';
   signal w_A   : std_logic := '0';
   signal w_B   : std_logic := '0';
   signal w_Y   : std_logic := '0';
   -- FOR u_Circ5: Circ5 USE ENTITY WORK.Circ5(mealy_arch);
begin
   u_Circ5 : Circ5
   port map(
      i_CLK => w_CLK,
      i_RST => w_RST,
      i_A   => w_A,
      i_B   => w_B,
      o_Y   => w_Y
   );
   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   process
   begin
    --   wait for 1 ps;
      -- w_RST <= '0';
      w_A   <= '1';
      w_B   <= '0';
      wait for 2 ps;
      assert w_Y = '0' report "Error @ Alfa -> Afla" severity Error;
      w_A <= '0';
      w_B <= '1';
      wait for 2 ps;
      assert w_Y = '1' report "Error @ Alfa -> Beta" severity Error;
      w_A <= '1';
      w_B <= '0';
      wait for 2 ps;
      assert w_Y = '1' report "Error @ Beta -> Charlie" severity Error;
      w_A <= '0';
      w_B <= '1';
      wait for 2 ps;
      assert w_Y = '0' report "Error @ Charlie -> Delta" severity Error;
      w_A <= '1';
      w_B <= '0';
      wait for 2 ps;
      assert w_Y = '0' report "Error @ Delta -> Alfa" severity Error;
      wait for 2 ps;
      w_A <= '0';
      w_B <= '0';
      wait for 2 ps;
      assert w_Y = '1' report "Error @ Alfa -> Charlie" severity Error;
      w_A <= '1';
      w_B <= '0';
      wait for 2 ps;
      assert w_Y = '1' report "Error @ Charlie -> Charlie" severity Error;
      w_A <= '0';
      w_B <= '1';
      wait for 2 ps;
      assert w_Y = '0' report "Error @ Charlie -> Delta" severity Error;
      w_RST <= '1';
      wait;
   end process;
end architecture;