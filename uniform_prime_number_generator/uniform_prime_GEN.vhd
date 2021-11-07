library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
use std.textio.all;

entity uniform_prime_GEN is
    Port (   clk        : in std_logic;
             rst        : in std_logic;
             min_q      : in std_logic_vector (15 downto 0);
             max_q      : in std_logic_vector (15 downto 0);
             result     : out std_logic_vector (15 downto 0));
end uniform_prime_GEN;

architecture Behavioral of uniform_prime_GEN is
    -- bram component
    type ram_type is array (154 downto 0) of std_logic_vector(15 downto 0);

    -- function for bram intialisation
    impure function initramfromfile(ramfilename: in string) return ram_type is
        file ramfile : text is in ramfilename;
        variable ramfileline : line;
        variable ram_name : ram_type;
        variable bitvec : bit_vector(15 downto 0);
    begin
        for i in ram_type'range loop
            readline(ramfile, ramfileline);
            read(ramfileline, bitvec);
            ram_name(i) := to_stdlogicvector(bitvec);
        end loop;
        return ram_name;
    end function;
    
    signal data_mem1    : ram_type := initramfromfile("C:\Users\ander\Desktop\cs3601\uniform_prime_number_generator\config1.txt");
    signal data_mem2    : ram_type := initramfromfile("C:\Users\ander\Desktop\cs3601\uniform_prime_number_generator\config2.txt");
    signal data_mem3    : ram_type := initramfromfile("C:\Users\ander\Desktop\cs3601\uniform_prime_number_generator\config3.txt");

    signal lfsr_reg     : std_logic_vector(15 downto 0) := x"0000";
    signal temp_reg     : std_logic_vector(15 downto 0) := x"0000";
    signal index_reg    : integer := 0;
    signal feedback     : std_logic := '0';
    signal is_prime     : std_logic := '1';
    signal index        : integer := 0;

begin  
    -- Process to access the prime table
    process (clk) is
    begin
        if rising_edge(clk) then            
            if (min_q = x"0000" and max_q = x"0080") then
                temp_reg <= data_mem1(index_reg);
            elsif (min_q = x"0800" and max_q = x"2000") then
                temp_reg <= data_mem2(index);
            elsif (min_q = x"4000" and max_q = x"FFFF") then
                temp_reg <= data_mem3(index);
            end if;
            result <= temp_reg;
        end if;
    end process;
    
    --  Process for RNG generating the index
    process(clk, rst) is 
    begin
        if (rst = '1') then
            lfsr_reg <= x"ABCD";
        elsif rising_edge(clk) then
            feedback <= lfsr_reg(15) xor lfsr_reg(14) xor lfsr_reg(12) xor lfsr_reg(3);
            lfsr_reg <= lfsr_reg(14 downto 0) & feedback;
            index_reg <= conv_integer(unsigned(lfsr_reg)) mod 155;
        end if;
    end process;
    
    index <= index_reg;
    
end Behavioral;