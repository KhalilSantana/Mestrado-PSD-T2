library ieee;
use ieee.std_logic_1164.all;

entity Circ5 is
   port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_A   : in std_logic;
      i_B   : in std_logic;
      o_Y   : out std_logic
   );
end entity;

architecture moore_arch of Circ5 is
   type state is (
      S_Alfa,
      S_Beta,
      S_Charlie,
      S_Delta
   );
   signal current_state, next_state : state;
begin
   process (i_CLK, i_RST)
   begin
      if i_RST = '1' then
         current_state <= S_Alfa;
      elsif rising_edge(i_CLK) then
         current_state <= next_state;
      end if;
   end process;
   process (current_state, i_A, i_B)
   begin
      case current_state is
         when S_Alfa =>
            if i_A = '1' then
               next_state <= S_Alfa;
            elsif i_A = '0' and i_B = '1' then
               next_state <= S_Beta;
            elsif i_A = '0' and i_B = '0' then
               next_state <= S_Charlie;
            else
               next_state <= S_Alfa;
            end if;
         when S_Beta =>
            if i_A = '1' then
               next_state <= S_Charlie;
            else
               next_state <= S_Beta;
            end if;
         when S_Charlie =>
            if i_B = '1' then
               next_state <= S_Delta;
            else
               next_state <= S_Charlie;
            end if;
         when S_Delta =>
            next_state <= S_Alfa;
         when others =>
            next_state <= S_Alfa;
      end case;
   end process;
   o_Y <=
      '0' when current_state = S_Alfa else
      '0' when current_state = S_Delta else
      '1' when current_state = S_Beta else
      '1' when current_state = S_Charlie else
      '0';
end architecture;