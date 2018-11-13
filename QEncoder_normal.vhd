library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity QEncoder is 
port(
		clk 	: in std_logic;
		reset	: in std_logic;
		a 		: in std_logic;
		b 		: in std_logic;

		counter : out std_logic_vector(15 downto 0)
	);
end entity;

architecture encoder of QEncoder is 
signal data_a, data_b 	: std_logic_vector(1 downto 0);
begin

	process(clk,reset)
	variable count : integer;
	begin
		if(reset='1') then
			counter <= (others=>'0');
			data_a <= (others=>'0');
			data_b <= (others=>'0');
			count := 0;			
		elsif(rising_edge(clk)) then
			data_a(1) <= data_a(0);
			data_a(0) <= a;

			data_b(1) <= data_b(0);
			data_b(0) <= b;

			case(data_a) is
				when "00" =>
					case(data_b) is
						when "10"  	=>	count := count+1;
						when "01"  	=>	count := count-1;	
						when others	=> 	count := count;
					end case ;
				when "01" =>
					case(data_b) is
						when "00"  =>	count := count+1;
						when "11"  =>	count := count-1;
						when others	=> 	count := count;			
					end case ;
				when "10" =>
					case(data_b) is
						when "11"  =>	count := count+1;
						when "00"  =>	count := count-1;
						when others	=> 	count := count;			
					end case ;
				when "11" =>
					case(data_b) is
						when "01"  =>	count := count+1;
						when "10"  =>	count := count-1;
						when others	=> 	count := count;			
					end case ;
				when others	=> 	count := count;			
			end case ;
		end if ;
		counter <= std_logic_vector(to_signed(count, counter'length));

	end process;


end architecture ; -- encoder