library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity uniform_random_GEN is
Port (  clk             : in std_logic;
        rst             : in std_logic;
        prime           : in std_logic_vector (15 downto 0);
        result          : out std_logic_vector (15 downto 0));
end uniform_random_GEN;

architecture Behavioral of uniform_random_GEN is

signal lfsr_reg         : std_logic_vector (15 downto 0);
signal feedback         : std_logic := '0';

begin
    
    process(clk, rst) is
        variable temp_reg : integer;
    begin
        lfsr_reg <= prime;
        feedback <= lfsr_reg(15) xor lfsr_reg(14) xor lfsr_reg(12) xor lfsr_reg(3);
        if (rst = '1') then
            result <= x"0000";
        elsif rising_edge(clk) then
            lfsr_reg <= feedback & lfsr_reg(15 downto 1);
            temp_reg := conv_integer(unsigned(lfsr_reg)) mod conv_integer(unsigned(prime));           
        end if;
        result <= conv_std_logic_vector (temp_reg, result'length);
    end process;
end Behavioral;