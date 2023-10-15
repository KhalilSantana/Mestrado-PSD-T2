library ieee;
use ieee.std_logic_1164.all;
entity secure_car_key is
  port
  (
    i_CLK : in std_logic; -- clock
    i_RST : in std_logic; -- reset/clear
    i_A   : in std_logic; -- input representing key in ignition
    o_R   : out std_logic -- data output
  );
end secure_car_key;
architecture arch_1 of secure_car_key is
  type t_STATE is (s_Wait, s_K1, s_K2, s_K3, s_K4);
  signal w_NEXT  : t_STATE; -- next state
  signal r_STATE : t_STATE; -- current state
begin
  -- State Register
  process (i_RST, i_CLK)
  begin
    if (i_RST = '1') then
      r_STATE <= s_Wait;
    elsif (rising_edge(i_CLK)) then
      r_STATE <= w_NEXT;
    end if;
  end process;

  -- Next State Function
  process (r_STATE, i_A)
  begin
    case r_STATE is
      when s_Wait => if (i_A = '0') then
        w_NEXT <= s_Wait;
      else
        w_NEXT <= s_K1;
    end if;
    when s_K1   => w_NEXT <= s_K2;
    when s_K2   => w_NEXT <= s_K3;
    when s_K3   => w_NEXT <= s_K4;
    when s_K4   => w_NEXT <= s_Wait;
    when others => w_NEXT <= s_Wait;
  end case;
end process;

-- Output Function
o_R <= '0' when (r_STATE = s_Wait) else
  '1' when (r_STATE = s_K1 or r_state = s_K2 or r_state = s_K4) else
  '0';
end arch_1;