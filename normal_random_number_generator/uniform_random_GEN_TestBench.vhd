library ieee;
use ieee.std_logic_1164.all;

entity TB_uniform_random_GEN is
end TB_uniform_random_GEN;

architecture bench of TB_uniform_random_GEN is

component uniform_random_GEN is
    Port (   clk        : in std_logic;
             rst        : in std_logic;
             min_q      : in std_logic_vector (4 downto 0);
             max_q      : in std_logic_vector (4 downto 0);
             valid      : out std_logic;
             result     : out std_logic_vector (4 downto 0));
end component;

    signal tb_clk       : std_logic := '0';
    signal tb_rst       : std_logic := '1';
    signal tb_valid     : std_logic;
    signal tb_temp1     : std_logic_vector (4 downto 0) := "00000";
    signal tb_temp2     : std_logic_vector (4 downto 0) := "00000";
    signal tb_result    : std_logic_vector (4 downto 0);

constant clock_period : time := 20 ns;

begin
    uut: uniform_random_GEN port map(  clk => tb_clk,
                                        rst => tb_rst,
                                        min_q => tb_temp1,
                                        max_q => tb_temp2,
                                        valid => tb_valid,
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
        tb_temp1 <= "-10000"; ---16
        tb_temp2 <= "10000"; --16
        wait for 10 ns;
        tb_rst <= '0';
        wait;
    end process;
    
end bench;