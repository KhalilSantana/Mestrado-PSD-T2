library ieee;
use ieee.std_logic_1164.all;
entity circ3_state_register is
   port (
      i_CLK : in std_logic;                    -- clock
      i_RST : in std_logic;                    -- reset/clear
      i_N   : in std_logic_vector(2 downto 0); -- next state
      o_S   : out std_logic_vector(2 downto 0) -- current state
   );
end circ3_state_register;

architecture arch_1 of circ3_state_register is
   signal w_NEXT : std_logic_vector(2 downto 0); -- next state
begin

   w_NEXT <= i_N;
   -- State Register
   process (i_RST, i_CLK)
   begin
      if (i_RST = '1') then
         o_S <= "000";
      elsif (rising_edge(i_CLK)) then
         o_S <= w_NEXT;
      end if;
   end process;
end arch_1;