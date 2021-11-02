library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uniform_random_GEN is
    Port (   clk        : in std_logic;
             rst        : in std_logic;
             min_e      : in std_logic_vector (4 downto 0);
             max_e      : in std_logic_vector (4 downto 0);
             result     : out std_logic_vector (4 downto 0));
end uniform_random_GEN;

architecture Behavioral of uniform_random_GEN is

    signal min          : std_logic_vector(4 downto 0) := min_e;
    signal max          : std_logic_vector(4 downto 0) := max_e;
    signal lfsr_reg     : std_logic_vector(4 downto 0);
    signal feedback     : std_logic;
   
begin
    process (clk, rst) is
        variable temp_reg     : integer;
    begin
        if (rst = '1') then
            result <= x"0000";
        elsif rising_edge (clk) then
            lfsr_reg <= max_e;
            feedback <= lfsr_reg(4) xor lfsr_reg(3);
            lfsr_reg <= feedback & lfsr_reg(4 downto 1);
            temp_reg := conv_integer(unsigned(lfsr_reg)) mod conv_integer(unsigned(max_e)); 
        end if;
        
        result <= conv_std_logic_vector (temp_reg, result'length);

    end process;
end Behavioral;