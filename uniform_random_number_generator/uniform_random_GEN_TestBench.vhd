library ieee;
use ieee.std_logic_1164.all;

entity TB_uniform_random_GEN is
end TB_uniform_random_GEN;

architecture bench of TB_uniform_random_GEN is

component uniform_random_GEN is
    Port (  clk             : in std_logic;
            rst             : in std_logic;
            prime           : in std_logic_vector (15 downto 0);
            result          : out std_logic_vector (15 downto 0));
end component;

constant num_cycles : integer := 10;
signal tb_clk       : std_logic := '0';
signal tb_rst       : std_logic := '1';
signal tb_prime      : std_logic_vector (15 downto 0);
signal tb_result    : std_logic_vector (15 downto 0);

begin
    mapping: uniform_random_GEN port map(   clk => tb_clk,
                                            rst => tb_rst,
                                            prime => tb_prime,
                                            result => tb_result);
    clock: process is
    begin
        for i in 1 to num_cycles loop
            tb_clk <= not tb_clk;
            wait for 5 ns;
            tb_clk <= not tb_clk;
            wait for 5 ns;
        end loop;
    end process;

    reset: process is
    begin
        tb_rst <= '1';
        tb_prime <= x"0061"; --97
        wait for 5 ns;
        tb_rst <= '0';
        wait;
    end process;
    
end bench;