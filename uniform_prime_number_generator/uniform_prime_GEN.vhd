library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uniform_prime_GEN is
    Port (   clk        : in std_logic;
             rst        : in std_logic;
             min_q      : in std_logic_vector (15 downto 0);
             max_q      : in std_logic_vector (15 downto 0);
             valid      : out std_logic;
             result     : out std_logic_vector (15 downto 0));
end uniform_prime_GEN;

architecture Behavioral of uniform_prime_GEN is

    signal lfsr_reg     : std_logic_vector(15 downto 0);
    signal feedback     : std_logic := '0';
    signal is_prime     : std_logic := '1';
   
begin
    process (clk, rst) is
        variable temp_reg     : integer;
    begin
        if (rst = '1') then
            lfsr_reg <= max_q;
            result <= x"0000";
            valid <= '0';
        elsif rising_edge (clk) then
            feedback <= lfsr_reg(15) xor lfsr_reg(14) xor lfsr_reg(12) xor lfsr_reg(3);
            lfsr_reg <= feedback & lfsr_reg(15 downto 1);
            
            if(min_q = x"0000" and max_q = x"0080") then
                temp_reg := conv_integer(unsigned(lfsr_reg)) mod 128;
            elsif (min_q = x"0800" and max_q = x"4000") then
                temp_reg := conv_integer(unsigned(lfsr_reg)) mod 6144;
                temp_reg := temp_reg + 2048;
            elsif (min_q = x"4000" and max_q = x"FFFF") then
                temp_reg := conv_integer(unsigned(lfsr_reg)) mod 49151;
                temp_reg := temp_reg + 49151;
            end if;
            
            if (temp_reg = 1 or temp_reg = 0) then
                is_prime <= '0';
            elsif (temp_reg > 2) then
                for i in 2 to temp_reg-1 loop
                    if (temp_reg mod i = 0) then
                        is_prime <= '0';
                        exit;
                    end if;
                end loop;
            end if;
            
            valid <= is_prime;
            result <= conv_std_logic_vector (temp_reg, result'length);
            
        end if;
    end process;
end Behavioral;
