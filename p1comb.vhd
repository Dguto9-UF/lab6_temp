library ieee;
use ieee.std_logic_1164.all;

entity comb is
  port (
    q0,ir1,ir0 : in std_logic;
    q0p,msa0,msa1,msb0,msb1,msc0,msc1,msc2,ir_ld : out std_logic
  );
end entity;

architecture rtl of comb is
  signal out : std_logic_vector(8 downto 0);
begin
  with (q0 & ir1 & ir0) select?
    out <= "100000001" when "0--",
           "010100000" when "100",
           "011011110" when "101",
           "011011010" when "110",
           "000010000" when "111",
           "000000000" when others;
    q0p <= out(0);
    msa0 <= out(1);
    msa1 <= out(2);
    msb0 <= out(3);
    msb1 <= out(4);
    msc0 <= out(5);
    msc1 <= out(6);
    msc2 <= out(7);
    ir_ld <= out(8);
end rtl;
