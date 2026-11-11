library ieee;
use ieee.std_logic_1164.all;

entity comb is
  port (
    q0, ir1, ir0 : in  std_logic;
    q0p, ir_ld   : out std_logic;
    msa, msb     : out std_logic_vector(1 downto 0);
    msc          : out std_logic_vector(2 downto 0)
  );
end entity;

architecture rtl of comb is
  signal output : std_logic_vector(6 downto 0);
begin
	q0p <= '1' when (q0 = '0') else '0';
	ir_ld <= '1' when (q0 = '0') else '0';
	output <=  "0101000" when std_logic_vector'(q0 & ir1 & ir0) = "100" else
					"1110111" when std_logic_vector'(q0 & ir1 & ir0) = "101" else
					"1110101" when std_logic_vector'(q0 & ir1 & ir0) = "110" else
					"0010000" when std_logic_vector'(q0 & ir1 & ir0) = "111" else
					"0110000";                                          
	msa   <= output(6 downto 5);
	msb   <= output(4 downto 3);
	msc   <= output(2 downto 0);
end rtl;