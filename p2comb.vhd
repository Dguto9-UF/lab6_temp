library ieee;
use ieee.std_logic_1164.all;

entity comb is
  port (
    q1,q0,ir2,ir1,ir0 : in std_logic;
    q1p,q0p,msa1,msa0,msb1,msb0,msc2,msc1,msc0,pc_inc,pc_ld,ir_ld : out std_logic
  );
end entity;

architecture rtl of comb is
  signal out : std_logic_vector(11 downto 0);
begin
  with (q1 & q0 & ir2 & ir1 & ir0) select?
    out <= "010000000001" when "00---",
           "000101000100" when "01000",
           "001110101100" when "01001",
           "100000000100" when "01010",
           "110000000100" when "01011",
           "001110111100" when "01100",
           "001110110100" when "01101",
           "000010000100" when "10---",
           "000110000010" when "11---",
           "000000000000" when others;
    q1p <= out(0);
    q0p <= out(1);
    msa0 <= out(2);
    msa1 <= out(3);
    msb0 <= out(4);
    msb1 <= out(5);
    msc0 <= out(6);
    msc1 <= out(7);
    msc2 <= out(8);
    pc_inc <= out(9);
    pc_ld <= out(10);
    ir_ld <= out(11);
end rtl;
