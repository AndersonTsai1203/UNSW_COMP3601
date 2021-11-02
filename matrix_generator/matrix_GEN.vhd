library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity matrix_generator is
    generic (row : integer;
             col : integer);
    Port (  clk                 : in std_logic;
            rst                 : in std_logic;
            write_enable        : in std_logic;
            address             : in std_logic_vector (4 downto 0);
            data_in             : in std_logic_vector (15 downto 0);
            data_out            : out std_logic_vector (15 downto 0));
end matrix_generator;

architecture Behavioral of matrix_generator is

type col_by_col is array (0 to col-1) of std_logic_vector (15 downto 0);
type row_by_row is array (0 to row-1) of col_by_col; 
signal sig_data_memory  : col_by_col;
signal sig_matrix       : row_by_row;

begin
    process (clk, rst)
        variable data_memory_array      : col_by_col;
        variable matrix                 : row_by_row;
    begin
        if (rst = '1') then
            for i in 0 to row-1 loop
                for j in 0 to col-1 loop
                    data_memory_array(j) := x"0000";
                end loop;
                matrix(i) := data_memory_array;
            end loop;
        elsif rising_edge (clk) then
            if (write_enable = '1') then
                data_memory_array(conv_integer(unsigned(address))) := data_in;
            end if;    
        end if;
        data_out <= data_memory_array(conv_integer(unsigned(address)));
        sig_data_memory <= data_memory_array;
        sig_matrix <= matrix;
    end process;   
end Behavioral;