library ieee;
use ieee.std_logic_1164.all;

entity circ3_controller is
   port (
      i_A : in std_logic;                      -- input 
      i_S : in std_logic_vector(2 downto 0);   -- Current state               
      o_R : out std_logic;                     -- Output
      o_N : out std_logic_vector(2 downto 0)); -- netxt state
end circ3_controller;

architecture arch_1 of circ3_controller is
   signal w_NEXT  : std_logic_vector(2 downto 0); -- next state
   signal r_STATE : std_logic_vector(2 downto 0); -- current state
   signal w_R     : std_logic;
begin

   r_STATE <= i_S;

   -- Next State Function
   process (w_NEXT, r_State, i_A)
   begin
      case r_STATE is
         when "000" => if (i_A = '0') then
            w_NEXT <= "000";
         else
            w_NEXT <= "001";
      end if;
      when "001"  => w_NEXT  <= "010";
      when "010"  => w_NEXT  <= "011";
      when "011"  => w_NEXT  <= "100";
      when "100"  => w_NEXT  <= "000";
      when others => w_NEXT <= "000";
   end case;
end process;

process (w_R, r_STATE)
begin
   if r_STATE = "001" or r_STATE = "010" or r_STATE = "100" then
      w_R <= '1';
   else
      w_R <= '0';
   end if;
end process;

-- Output Function
o_R <= w_R;
o_N <= w_Next;

end arch_1;