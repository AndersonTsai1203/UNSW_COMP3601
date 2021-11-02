library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity signed_adder is
    Port ( clk  : in  std_logic;
           a    : in  std_logic_vector (4 downto 0);
           b    : in  std_logic_vector (4 downto 0);
           r    : out  std_logic_vector (4 downto 0));      
end signed_adder;

architecture Behavioral of signed_adder is

signal r_next : std_logic_vector(4 downto 0) := (others => '0');

begin

process(clk)

begin

if rising_edge(clk) then
    r <= r_next;
    r_next <= conv_std_logic_vector((signed(a) + signed(b)), r_next'length);
end if;

end process;

end Behavioral;
