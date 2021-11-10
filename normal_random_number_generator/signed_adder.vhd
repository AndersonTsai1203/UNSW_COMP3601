library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity adder_signed is
    Port ( clk      : in  std_logic;
           min_e    : in std_logic_vector (5 downto 0);
           max_e    : in std_logic_vector (5 downto 0);
           a        : in  std_logic_vector (5 downto 0);
           b        : in  std_logic_vector (5 downto 0);
           r        : out  std_logic_vector (5 downto 0));      
end adder_signed;

architecture Behavioral of adder_signed is
    
    signal adder        : integer;
    signal subtractor   : integer;
    signal result       : integer;
    signal r_next       : std_logic_vector(5 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then
            r <= r_next;
            subtractor <= conv_integer (signed(max_e)) - conv_integer (signed(min_e));
            adder <= (conv_integer (signed(a)) + conv_integer (signed(b))) mod subtractor + conv_integer (signed(min_e));
            r_next <= conv_std_logic_vector(adder, r_next'length);
        end if;
    end process;
end Behavioral;