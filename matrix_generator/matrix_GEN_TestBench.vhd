library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity TB_matrix_generator is
end TB_matrix_generator;

architecture Behavioral of TB_matrix_generator is

component matrix_generator is
    generic (row : integer; col : integer);
    port (  clk                 : in std_logic;
            rst                 : in std_logic;
            write_enable        : in std_logic;
            address             : in std_logic_vector (4 downto 0);
            data_in             : in std_logic_vector (15 downto 0);
            data_out            : out std_logic_vector (15 downto 0));
end component;

constant num_cycles     : integer := 10;
signal tb_clk           : std_logic := '0';
signal tb_rst           : std_logic := '1';
signal tb_write_enable  : std_logic;
signal tb_address       : std_logic_vector (4 downto 0) := "00000";
signal tb_data_in       : std_logic_vector (15 downto 0);
signal tb_data_out      : std_logic_vector (15 downto 0);

begin
    mapping: matrix_generator generic map (row => 16, col => 4)
                     port map ( clk => tb_clk,
                                rst => tb_rst,
                                write_enable => tb_write_enable,
                                address =>tb_address,
                                data_in => tb_data_in,
                                data_out => tb_data_out);
   
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
       wait for 5 ns;
       tb_rst <= '0';
       tb_write_enable <= '1';
       tb_data_in <= x"0011"; --17
       wait for 5 ns;
       tb_address <= tb_address + 1;
    end process;
    
end Behavioral;
