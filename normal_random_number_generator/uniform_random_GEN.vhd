library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity random_uniform1 is
    Port ( clk      : in std_logic;
           rst      : in std_logic;
           min_e    : in std_logic_vector (5 downto 0);
           max_e    : in std_logic_vector (5 downto 0);
           result   : out std_logic_vector (5 downto 0));
end random_uniform1;

architecture Behavioral of random_uniform1 is

    signal lfsr_reg : std_logic_vector (5 downto 0);
    signal subtractor : integer;
    signal feedback : std_logic := '0';

begin
    process(clk,rst)
    begin
        if rst = '1' then
            lfsr_reg <= max_e;
        elsif rising_edge(clk) then
            feedback <= lfsr_reg(0) xor lfsr_reg(3);
            lfsr_reg <= feedback & lfsr_reg(5 downto 1);
            subtractor <= conv_integer (signed(max_e)) - conv_integer (signed(min_e));
            result <= conv_std_logic_vector (conv_integer (signed (lfsr_reg)) mod subtractor, result'length);
        end if;
    end process;

end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity random_uniform2 is
    Port ( clk      : in std_logic;
           rst      : in std_logic;
           min_e    : in std_logic_vector (5 downto 0);
           max_e    : in std_logic_vector (5 downto 0);
           result   : out std_logic_vector (5 downto 0));
end random_uniform2;

architecture Behavioral of random_uniform2 is

    signal lfsr_reg : std_logic_vector (5 downto 0);
    signal subtractor : integer;
    signal feedback : std_logic := '0';

begin
    process(clk,rst)
    begin
        if rst = '1' then
            lfsr_reg <= max_e;
        elsif rising_edge(clk) then
            feedback <= lfsr_reg(5) xor lfsr_reg(1);
            lfsr_reg <= feedback & lfsr_reg(5 downto 1);
            subtractor <= conv_integer (signed(max_e)) - conv_integer (signed(min_e));
            result <= conv_std_logic_vector (conv_integer (signed (lfsr_reg)) mod subtractor, result'length);
        end if;
    end process;

end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity random_uniform3 is
    Port ( clk      : in std_logic;
           rst      : in std_logic;
           min_e    : in std_logic_vector (5 downto 0);
           max_e    : in std_logic_vector (5 downto 0);
           result   : out std_logic_vector (5 downto 0));
end random_uniform3;

architecture Behavioral of random_uniform3 is

    signal lfsr_reg : std_logic_vector (5 downto 0);
    signal subtractor : integer;
    signal feedback : std_logic := '0';

begin
    process(clk,rst)
    begin
        if rst = '1' then
            lfsr_reg <= max_e;
        elsif rising_edge(clk) then
            feedback <= lfsr_reg(5) xor lfsr_reg(3);
            lfsr_reg <= feedback & lfsr_reg(5 downto 1);
            subtractor <= conv_integer (signed(max_e)) - conv_integer (signed(min_e));
            result <= conv_std_logic_vector (conv_integer (signed (lfsr_reg)) mod subtractor, result'length);
        end if;
    end process;

end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity random_uniform4 is
    Port ( clk      : in std_logic;
           rst      : in std_logic;
           min_e    : in std_logic_vector (5 downto 0);
           max_e    : in std_logic_vector (5 downto 0);
           result   : out std_logic_vector (5 downto 0));
end random_uniform4;

architecture Behavioral of random_uniform4 is

    signal lfsr_reg : std_logic_vector (5 downto 0);
    signal subtractor : integer;
    signal feedback : std_logic := '0';

begin
    process(clk,rst)
    begin
        if rst = '1' then
            lfsr_reg <= max_e;
        elsif rising_edge(clk) then
            feedback <= lfsr_reg(4) xor lfsr_reg(2);
            lfsr_reg <= feedback & lfsr_reg(5 downto 1);
            subtractor <= conv_integer (signed(max_e)) - conv_integer (signed(min_e));
            result <= conv_std_logic_vector (conv_integer (unsigned (lfsr_reg)) mod subtractor, result'length);
        end if;
    end process;

end Behavioral;
