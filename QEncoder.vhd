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
type state is (state0, state1, state2, state3, NR);
signal state_a , state_b : state;
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
				when "00" => state_a <= state0;
				when "01" => state_a <= state1;
				when "10" => state_a <= state2;
				when "11" => state_a <= state3;	
				when others => state_a <= NR;		
			end case ;
			case(data_b) is
				when "00" => state_b <= state0;
				when "01" => state_b <= state1;
				when "10" => state_b <= state2;
				when "11" => state_b <= state3;			
				when others => state_b <= NR;
			end case ;

			case(state_a) is
				when state0 =>
					case(state_b) is
						when state2  	=>	count := count+1;
						when state1  	=>	count := count-1;	
						when others		=> 	count := count;
					end case ;
				when state1 =>
					case(state_b) is
						when state0  	=>	count := count+1;
						when state3 	=>	count := count-1;
						when others		=> 	count := count;			
					end case ;
				when state2 =>
					case(state_b) is
						when state3  	=>	count := count+1;
						when state0 	=>	count := count-1;
						when others		=> 	count := count;			
					end case ;
				when state3 =>
					case(state_b) is
						when state1  	=>	count := count+1;
						when state2  	=>	count := count-1;
						when others		=> 	count := count;			
					end case ;
				when others	=> 	count := count;			
			end case ;
		end if ;
		counter <= std_logic_vector(to_signed(count, counter'length));

	end process;


end architecture ; -- encoder