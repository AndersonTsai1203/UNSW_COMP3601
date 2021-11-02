library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity normal_rng is
    Port ( clk      : in  std_logic;
           reset    : in  std_logic;
           random   : out  std_logic_vector (4 downto 0));
end normal_rng;

architecture Behavioral of normal_rng is

component random_uniform is 
    generic ( seed  : std_logic_vector(4 downto 0));
    port( clk       : in  std_logic;
          random    : out  std_logic_vector (4 downto 0);
          reset     : in  std_logic);
end component;

component signed_adder is
    Port ( clk  : in  std_logic;
           a    : in  std_logic_vector (4 downto 0);
           b    : in  std_logic_vector (4 downto 0);
           r    : out  std_logic_vector (4 downto 0));      
end component;

signal uniform1 : std_logic_vector(4 downto 0);
signal uniform2 : std_logic_vector(4 downto 0);
signal uniform3 : std_logic_vector(4 downto 0);
signal uniform4 : std_logic_vector(4 downto 0);

signal adder_a : std_logic_vector(4 downto 0);
signal adder_b : std_logic_vector(4 downto 0);
signal adder_r : std_logic_vector(4 downto 0);

type statetype is (s0, s1, s2);

signal state, next_state: statetype := s0;

begin

unif1: random_uniform 
    generic map (seed => -"10000")
    port map( clk => clk,
              random => uniform1,
              reset => reset);

unif2: random_uniform 
    generic map (seed => "00000")
    port map( clk => clk,
              random => uniform2,
              reset => reset);

unif3: random_uniform 
    generic map (seed => -"10000")
    port map( clk => clk,
              random => uniform3,
              reset => reset);

unif4: random_uniform 
    generic map (seed => -"10000")
    port map( clk => clk,
              random => uniform4,
              reset => reset);

adder1 : signed_adder
    port map ( a => adder_a,
               b => adder_b,
               clk => clk,
               r => adder_r); 

process(clk, reset)
begin

if rising_edge(clk) then
    if reset = '1' then
        state <= s0;
        random <= (others => '0');
    else
        if state = s0 then
            random <= adder_r;
        end if;
        state <= next_state;
end if;

end if;
end process;


process(clk,state,uniform1,uniform2,uniform3,uniform4,adder_r)

begin

case state is

    when s0 =>
        -- Sign extend
        adder_a <=  uniform1(4) & uniform1(4) & uniform1(4) & uniform1(1 downto 0);
        adder_b <=  uniform2(4) & uniform2(4) & uniform2(4) & uniform2(1 downto 0);

        next_state <= s1;

    when s1 =>
        adder_a <= adder_r;
        adder_b <= uniform3(4) & uniform3(4) & uniform3(4) & uniform3(1 downto 0);

        next_state <= s2;

    when s2 =>
        adder_a <= adder_r;
        adder_b <= uniform4(4) & uniform4(4) & uniform4(4) & uniform4(1 downto 0);

        next_state <= s0;

end case;
end process;

end Behavioral;