library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity random_gaussian is
    Port ( clk      : in std_logic;
           rst      : in std_logic;
           min_e    : in std_logic_vector (5 downto 0);
           max_e    : in std_logic_vector (5 downto 0);
           result   : out std_logic_vector (5 downto 0));
end random_gaussian;

architecture Behavioral of random_gaussian is

    component random_uniform1 is 
        port( clk       : in std_logic;
              rst       : in std_logic;
              min_e    : in std_logic_vector (5 downto 0);
              max_e    : in std_logic_vector (5 downto 0);
              result    : out std_logic_vector (5 downto 0));
    end component;
    
    component random_uniform2 is 
        port( clk       : in std_logic;
              rst       : in std_logic;
              min_e    : in std_logic_vector (5 downto 0);
              max_e    : in std_logic_vector (5 downto 0);
              result    : out std_logic_vector (5 downto 0));
    end component;
    
    component random_uniform3 is 
        port( clk       : in std_logic;
              rst       : in std_logic;
              min_e    : in std_logic_vector (5 downto 0);
              max_e    : in std_logic_vector (5 downto 0);
              result    : out std_logic_vector (5 downto 0));
    end component;
    
    component random_uniform4 is 
        port( clk       : in std_logic;
              rst       : in std_logic;
              min_e    : in std_logic_vector (5 downto 0);
              max_e    : in std_logic_vector (5 downto 0);
              result    : out std_logic_vector (5 downto 0));
    end component;

    component adder_signed is
        port ( clk      : in std_logic;
               min_e    : in std_logic_vector (5 downto 0);
               max_e    : in std_logic_vector (5 downto 0);
               a        : in std_logic_vector (5 downto 0);
               b        : in std_logic_vector (5 downto 0);
               r        : out std_logic_vector (5 downto 0));      
    end component;

    signal uniform1 : std_logic_vector(5 downto 0);
    signal uniform2 : std_logic_vector(5 downto 0);
    signal uniform3 : std_logic_vector(5 downto 0);
    signal uniform4 : std_logic_vector(5 downto 0);
    
    signal adder_a : std_logic_vector(5 downto 0);
    signal adder_b : std_logic_vector(5 downto 0);
    signal adder_r : std_logic_vector(5 downto 0);


begin
    unif1: random_uniform1 port map( clk => clk,
                                    rst => rst,
                                    min_e => min_e,
                                    max_e => max_e,
                                    result => uniform1);
    
    unif2: random_uniform2 port map( clk => clk,
                                    rst => rst,
                                    min_e => min_e,
                                    max_e => max_e,
                                    result => uniform2);
    
    unif3: random_uniform3 port map( clk => clk,
                                    rst => rst,
                                    min_e => min_e,
                                    max_e => max_e,
                                    result => uniform3);
                                                            
    unif4: random_uniform4 port map( clk => clk,
                                    rst => rst,
                                    min_e => min_e,
                                    max_e => max_e,
                                    result => uniform4);

    adder1 : adder_signed port map ( a => uniform1(5 downto 0),
                                     b => uniform2(5 downto 0),
                                     min_e => min_e,
                                     max_e => max_e,
                                     clk => clk,
                                     r => adder_a);
    
    adder2 : adder_signed port map ( a => adder_a,
                                     b => uniform3(5 downto 0),
                                     min_e => min_e,
                                     max_e => max_e,
                                     clk => clk,
                                     r => adder_b);
                                     
    adder3 : adder_signed port map ( a => adder_b,
                                     b => uniform4(5 downto 0),
                                     min_e => min_e,
                                     max_e => max_e,
                                     clk => clk,
                                     r => adder_r);                                 
    process(clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                result <= "000000";
            else
                result <= adder_r;
            end if;
        end if;
    end process;
end Behavioral;