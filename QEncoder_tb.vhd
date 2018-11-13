library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity QEncoder_tb is

end Entity;

architecture encoder_tb of QEncoder_tb is
component QEncoder is 
port(
		clk 	: in std_logic;
		reset	: in std_logic;
		a 		: in std_logic;
		b 		: in std_logic;

		counter : out std_logic_vector(15 downto 0)
	);
end component;

component QEncoder_ts is
  Port (
  		clk 	: out std_logic;
  		reset 	: out std_logic;
  		a 		: out std_logic;
  		b 		: out std_logic
  		);
  end component;

signal clk_i, reset_i, a_i, b_i	: std_logic;
signal counter_i 				: std_logic_vector(15 downto 0);
begin
co_tb: QEncoder port map(clk 		=>	clk_i,
						 reset 		=>	reset_i,
						 a 			=>	a_i,
						 b 			=>	b_i,
						 counter 	=>	counter_i);

ts_tb: QEncoder_ts port map(
							clk 	=>	clk_i,
							reset 	=>	reset_i,
							a 	 	=>	a_i,
							b 	 	=>	b_i
							);

end architecture;