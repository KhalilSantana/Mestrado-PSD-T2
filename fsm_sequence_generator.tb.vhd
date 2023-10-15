library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end entity;

architecture tb of testbench is
  component fsm_sequence_generator is
    port
    (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      o_Z   : out std_logic_vector(3 downto 0)
    );
  end component;

  signal w_CLK : std_logic                    := '0';
  signal w_RST : std_logic                    := '1';
  signal w_Z   : std_logic_vector(3 downto 0) := "0001";

begin

  u_fsm_sequence_generator : fsm_sequence_generator

  port map
  (
    i_CLK => w_CLK,
    i_RST => w_RST,
    o_Z   => w_Z
  );

  process (w_CLK)
  begin
    w_CLK <= not w_CLK after 1 ps;
  end process;

  process
  begin
    w_RST <= '1';
    wait for 1 ps;
    assert(w_Z = "0001") report "S_A" severity error;

    w_RST <= '0';
    wait for 1 ps;
    assert(w_Z = "0001") report "S_A" severity error;

    wait for 1.5 ps;
    assert(w_Z = "0011") report "S_A -> S_B" severity error;

    wait for 1.5 ps;
    assert(w_Z = "1100") report "S_B -> S_C" severity error;

    wait for 1.5 ps;
    assert(w_Z = "1000") report "S_C -> S_D" severity error;

    wait for 1.5 ps;
    assert(w_Z = "0001") report "S_D -> S_A" severity error;

    wait;
  end process;

end architecture;