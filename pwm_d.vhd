library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PWM_module_d is
	port( 
		  clk 			: in std_logic;
		  rst			: in std_logic;
		  enable 		: in std_logic;
		  dutycycle 	: in std_logic_vector (7 downto 0);
		  dir		 	: in std_logic_vector (1 downto 0);
		  
		  DC   			: out std_logic ;
		  Dir1 			: out std_logic;
		  Dir2			: out std_logic
		);
end entity;

architecture pwm of pwm_module_d is
signal ontime, offtime : integer;
begin
Dir1 <= dir(1);
Dir2 <= dir(0);

	process(clk,rst)
		variable ontime, offtime, duty_i : integer := 0;
	begin		
		if(rst = '1') then
			DC <= '0';
			ontime := 0;
			offtime := 0;
			duty_i := 0;
		elsif(rising_edge(clk)) then
			if(enable='1') then
				duty_i 	:= to_integer(unsigned(dutycycle));
				ontime 	:= ((duty_i) * 25);
				offtime := 2500 - (((duty_i)) * 25);
			end if;
		end if;
	end process;

	process(clk)
	variable count : integer;
	begin
		if(rst = '1') then
			count := 0;
		elsif(rising_edge(clk)) then
			
			if(count<ontime) then
				DC<='1';		
			end if;	
			if(count<offtime) then
				DC<='0';
			end if;
			if(count>offtime) then
				count:=0;
			else
				count := count+1;	
			end if;
		end if ;

	end process;

end architecture ; -- pwmodule_d