library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM is
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
end entity;

architecture pwm_arch of PWM is
signal counter  : integer;
signal limit	: integer;
signal restart 	: std_logic;
begin
--directions
INA <= dir(1);
INB <= dir(0);

--PWM generator
process(clk,reset)
begin
	if (reset='1') then
		counter <= 0;
		limit <= 0;
		restart <= '0';
	elsif(rising_edge(clk)) then
		if(enable = '1') then
			limit <= to_integer(unsigned(dutycycle))*25;
			restart <= '1';
		end if;

		if(rising_edge(clk)) then
			if(restart = '0') then
				counter <= counter + 1;
			else
				counter <= 0;
				restart <= '0';
			end if;
		end if;
	end if;

	if(counter < limit) then
		C <= '1';	
	else 
		C <= '0';	
	end if;

	if(counter > 2500) then
		restart <= '1';
	else 
		restart <= '0';	
	end if;	
end process;

end architecture;