library ieee;
use ieee.std_logic_1164.all;

entity TB_uniform_prime_GEN is
end TB_uniform_prime_GEN;

architecture bench of TB_uniform_prime_GEN is

component uniform_prime_GEN is
    Port (   clk        : in std_logic;
             rst        : in std_logic;
             min_q      : in std_logic_vector (15 downto 0);
             max_q      : in std_logic_vector (15 downto 0);
             result     : out std_logic_vector (15 downto 0));
end component;

    signal tb_clk       : std_logic := '0';
    signal tb_rst       : std_logic := '1';
    signal tb_min       : std_logic_vector (15 downto 0);
    signal tb_max       : std_logic_vector (15 downto 0);
    signal tb_result    : std_logic_vector (15 downto 0);

constant clock_period : time := 10 ns;

begin
    uut: uniform_prime_GEN port map(  clk => tb_clk,
                                        rst => tb_rst,
                                        min_q => tb_min,
                                        max_q => tb_max,
                                        result => tb_result);
    clock :process
    begin
        tb_clk <= '0';
        wait for clock_period/2;
        tb_clk <= '1';
        wait for clock_period/2;
    end process;
    
    stim_proc: process
    begin
        tb_rst <= '1';
        --tb_min <= x"0000"; --0
        --tb_max <= x"0080"; --128
        --tb_min <= x"0800"; --2048
        --tb_max <= x"2000"; --8192
        tb_min <= x"4000"; --16384
        tb_max <= x"FFFF"; --65535
        wait for 5 ns;
        tb_rst <= '0';
        wait;
    end process;
    
end bench;