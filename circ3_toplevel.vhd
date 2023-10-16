library ieee;
use ieee.std_logic_1164.all;

entity circ3_toplevel is
   port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_A   : in std_logic;
      o_R   : out std_logic
   );
end entity;

architecture rtl of circ3_toplevel is
   signal w_n_S : std_logic_vector(2 downto 0) := "000";
   signal w_c_S : std_logic_vector(2 downto 0) := "000";
   component circ3_controller is
      port (
         i_A : in std_logic;                      -- input 
         i_S : in std_logic_vector(2 downto 0);   -- Current state               
         o_R : out std_logic;                     -- Output
         o_N : out std_logic_vector(2 downto 0)); -- netxt state
   end component;
   component circ3_state_register is
      port (
         i_CLK : in std_logic;                    -- clock
         i_RST : in std_logic;                    -- reset/clear
         i_N   : in std_logic_vector(2 downto 0); -- next state
         o_S   : out std_logic_vector(2 downto 0) -- current state
      );
   end component;
begin

   u_Controller : circ3_controller
   port map(
      i_A => i_A,
      i_S => w_c_S,
      O_N => w_n_S,
      o_R => o_R
   );

   u_Register : circ3_state_register port map(
      i_CLK => i_CLK,
      i_RST => i_RST,
      i_N   => w_n_S,
      o_S   => w_c_S
   );
end architecture;