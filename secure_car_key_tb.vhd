library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture tb of testbench is
   component secure_car_key is
      port (
         i_CLK : in std_logic;
         i_RST : in std_logic;
         i_A   : in std_logic;
         o_R   : out std_logic
      );
   end component;
   
   signal w_CLK : std_logic := '0';
   signal w_RST : std_logic := '1';
   signal w_A   : std_logic := '0';
   signal w_R   : std_logic := '0';
begin 

  u_secure_car_key : secure_car_key
   
   port map(
      i_CLK => w_CLK,
      i_RST => w_RST,
      i_A => w_A,
      o_R   => w_R
   );

   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   
   process
   begin
     w_RST <= '1';
     w_A <= '0';
     wait for 1 ps;
     assert(w_R = '0') report "WAIT" severity error;
     
     w_RST <= '0';
     wait for 1 ps;
     assert(w_R = '0') report "WAIT" severity error;
     
     w_A <= '1';
     wait for 1.5 ps;
     assert(w_R = '1') report "K1" severity error;
      
     wait for 1.5 ps;
     assert(w_R = '1') report "K2" severity error;
     
     wait for 1.5 ps;
     assert(w_R = '0') report "K3" severity error;
     
	 wait for 1.5 ps;
     assert(w_R = '1') report "K4" severity error;

     wait for 3 ps;
     
     w_A <= '1';
      
   wait;
   end process;

end architecture;