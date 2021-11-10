library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity random_gaussian_test_bench is
end random_gaussian_test_bench;

architecture Behavioral of random_gaussian_test_bench is

    component random_gaussian is
        port ( clk      : in std_logic;
               rst      : in std_logic;
               min_e    : in std_logic_vector (5 downto 0);
               max_e    : in std_logic_vector (5 downto 0);
               result   : out std_logic_vector (5 downto 0));
    end component;

   --Inputs
   signal tb_clk    : std_logic := '0';
   signal tb_rst    : std_logic := '0';
   signal tb_min_e  : std_logic_vector (5 downto 0);
   signal tb_max_e  : std_logic_vector (5 downto 0);

    --Outputs
   signal tb_result : std_logic_vector (5 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: random_gaussian port map ( clk => tb_clk,
                                    rst => tb_rst,
                                    min_e => tb_min_e,
                                    max_e => tb_max_e,
                                    result => tb_result);

    -- Clock process definitions
    clk_process :process
    begin
        tb_clk <= '0';
        wait for clk_period/2;
        tb_clk <= '1';
        wait for clk_period/2;
   end process;

    -- Stimulus process
    stim_proc: process
    begin
        tb_rst <= '1';
        --tb_min_e <= "111111"; -- -1
        --tb_max_e <= "000001"; -- 1
        --tb_min_e <= "111100"; -- -4
        --tb_max_e <= "000100"; -- 4
        tb_min_e <= "110000"; -- -16
        tb_max_e <= "010000"; -- 16
        wait for 5 ns;
        tb_rst <= '0';
        wait;
    end process;

END;