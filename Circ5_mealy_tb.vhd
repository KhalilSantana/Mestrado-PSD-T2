library ieee;
use ieee.std_logic_1164.all;

entity Circ5_mealy_tb is
end entity;

architecture tb of Circ5_mealy_tb is
   component Circ5_mealy is
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
begin
   u_Circ5 : Circ5_mealy
   port map(
      i_CLK => w_CLK,
      i_RST => w_RST,
      i_A   => w_A,
      i_B   => w_B,
      o_Y   => w_Y
   );
   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 5 ps;
   end process;
   process
   begin
      w_A <= '0';
      w_B <= '1';
      wait for 1 ps;
      assert w_Y = '1' report "Error @ Alfa -> Beta (w/o clk^)" severity Error;
      w_A <= '1';
      w_B <= '0';
      wait for 1 ps;
      assert w_Y = '0' report "Error @ Alfa -> Alfa (w/o clk^)" severity Error;
      w_A <= '0';
      w_B <= '0';
      wait for 2 ps;
      assert w_Y = '1' report "Error @ Alfa -> Charlie (w/o clk^)" severity Error;
      wait for 1 ps; -- rising_edge(clk)
      w_A <= '0';
      w_B <= '1';
      wait for 1 ps;
      assert  w_Y = '0' report "Error @ Charlie -> Delta (w/o clk^)" severity Error;
      wait for 9 ps;
      w_A <= '0';
      w_B <= '0';
      assert  w_Y = '0' report "Error @ Delta -> Alfa (w/o clk^)" severity Error;
      wait;
   end process;
end architecture;