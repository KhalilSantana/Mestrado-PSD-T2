library ieee;
use ieee.std_logic_1164.all;

entity Circ5_mealy is
   port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      i_A   : in std_logic;
      i_B   : in std_logic;
      o_Y   : out std_logic
   );
end entity;

architecture mealy_arch of Circ5_mealy is
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
                o_Y <= '0';
             elsif i_A = '0' and i_B = '1' then
                next_state <= S_Beta;
                o_Y <= '1';
             elsif i_A = '0' and i_B = '0' then
                next_state <= S_Charlie;
                o_Y <= '1';
             else
                next_state <= S_Alfa;
                o_Y <= '0';
             end if;
          when S_Beta =>
             if i_A = '1' then
                next_state <= S_Charlie;
                o_Y <= '1';
             else
                next_state <= S_Beta;
                o_Y <= '1';
             end if;
          when S_Charlie =>
             if i_B = '1' then
                next_state <= S_Delta;
                o_Y <= '0';
             else
                next_state <= S_Charlie;
                o_Y <= '1';
             end if;
          when S_Delta =>
             next_state <= S_Alfa;
             o_Y <= '0';
          when others =>
             next_state <= S_Alfa;
             o_Y <= '0';
       end case;
    end process;
 end architecture;