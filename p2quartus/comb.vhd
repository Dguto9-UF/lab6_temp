library ieee;
use ieee.std_logic_1164.all;

entity comb is
  port (
    q0, q1 : in  std_logic;
	 ir : in std_logic_vector(2 downto 0);
    q0p, q1p, ir_ld, pc_ld, pc_inc : out std_logic;
    msa, msb     : out std_logic_vector(1 downto 0);
    msc          : out std_logic_vector(2 downto 0)
  );
end entity;

architecture rtl of comb is
  signal output : std_logic_vector(11 downto 0);
begin
	output <= "010110000001" when std_logic_vector'(q1 & q0) = "00" else
					"000101000100" when std_logic_vector'(q1 & q0 & ir) = "01000" else
					"001110101100" when std_logic_vector'(q1 & q0 & ir) = "01001" else
					"100000000100" when std_logic_vector'(q1 & q0 & ir) = "01010" else
					"110000000100" when std_logic_vector'(q1 & q0 & ir) = "01011" else
					"001110111100" when std_logic_vector'(q1 & q0 & ir) = "01100" else
					"001110110100" when std_logic_vector'(q1 & q0 & ir) = "01101" else
					"000010000100" when std_logic_vector'(q1 & q0) = "10" else
					"000110000010" when std_logic_vector'(q1 & q0) = "11" else
					"000110000100";
	q1p <= output(11);
	q0p <= output(10);
	msa <= output(9 downto 8);
	msb <= output(7 downto 6);
	msc <= output(5 downto 3);
	pc_inc <= output(2);
	pc_ld <= output(1);
	ir_ld <= output(0);
end rtl;