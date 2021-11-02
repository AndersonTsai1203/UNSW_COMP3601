library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_normal_rng is
end TB_normal_rng;

architecture behavioral of TB_normal_rng is

    component normal_rng
    port(
         clk    : in  std_logic;
         reset  : in  std_logic;
         random : out  std_logic_vector(4 downto 0)
        );
    end component;


   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

    --Outputs
   signal random : std_logic_vector(4 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
   uut: normal_rng port map ( clk => clk,
                              reset => reset,
                              random => random);

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;


    -- Stimulus process
    stim_proc: process
    variable I : integer;
    begin        
        reset <= '1';
        wait for clk_period*20;

        reset <= '0';
        wait for clk_period*30;
        wait;
   end process;

end behavioral;