library ieee;
use ieee.std_logic_1164.all;

entity circ3_controller is
  port (
     i_A : in std_logic; 							   -- input 
     i_S : in std_logic_vector(2 downto 0);     -- Current state               
	  o_R: out std_logic;								-- Output
     o_N   : out std_logic_vector(2 downto 0)); -- netxt state
end circ3_controller;

architecture arch_1 of circ3_controller is
  signal w_NEXT  : std_logic_vector(2 downto 0); -- next state
  signal r_STATE : std_logic_vector(2 downto 0); -- current state
  signal w_R : std_logic;
begin

	r_STATE <= i_S;
	
	o_R <= '1' when (r_STATE(2) = '1' and r_STATE(1) = '0' and r_STATE(0) = '0')
					or  (r_STATE(2) = '0' and r_STATE(1) = '1' and r_STATE(0) = '0')
					or  (r_STATE(2) = '0' and r_STATE(1) = '0' and r_STATE(0) = '1')
					else '0';
					
	w_NEXT(0) <= '1' when (r_STATE(2) = '0' and r_STATE(1) = '1' and r_STATE(0) = '0')
							or  (r_STATE(2) = '0' and r_STATE(0) = '0' and i_A = '1')
							else '0';

	w_NEXT(1) <= '1' when (r_STATE(2) = '0' and r_STATE(1) = '1' and r_STATE(0) = '0')
							or  (r_STATE(2) = '0' and r_STATE(1) = '0' and r_STATE(0) = '1')
							else '0';
							
	w_NEXT(2) <= '1' when (r_STATE(2) = '0' and r_STATE(1) = '1' and r_STATE(0) = '1')

							else '0';	


  -- Output Function
  o_N <= w_Next;
  
end arch_1;