library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm_new_tb is
end entity;

architecture tb_pwm_new of pwm_new_tb is
component PWM is
port(
		clk 		: in std_logic;
		reset 		: in std_logic;
		enable		: in std_logic;
		dutycycle	: in std_logic_vector(7 downto 0);
		dir			: in std_logic_vector(1 downto 0);

		C			: out std_logic;
		INA			: out std_logic;
		INB			: out std_logic
	);
end component;

component pwm_ts is 
  Port(
       clk     		: out std_logic;
       reset   		: out std_logic;
       enable  		: out std_logic;
       dutycycle    : out std_logic_vector(7 downto 0);
       dir     		: out std_logic_vector(1 downto 0) 
      );
end component;


signal clk_i, reset_i, enable_i, C_i, INA_i, INB_i : std_logic;
signal dutycycle_i  : std_logic_vector(7 downto 0);
signal dir_i		: std_logic_vector(1 downto 0);  

begin

co_tb: PWM port map( clk		  => clk_i,
				reset 	  => reset_i,
				enable 	  => enable_i,
				dutycycle => dutycycle_i,
				dir 	  => dir_i,
				C 		  => C_i,
				INA 	  => INA_i,
				INB 	  => INB_i
				);
ts_tb: pwm_ts port map( clk 	  => clk_i,
				reset 	  => reset_i,
				enable 	  => enable_i,
				dutycycle => dutycycle_i,
				dir 	  => dir_i	
				);

end architecture;