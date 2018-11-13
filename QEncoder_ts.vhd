library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity QEncoder_ts is
  Port (
  		clk 	: out std_logic;
  		reset 	: out std_logic;
  		a 		: out std_logic;
  		b 		: out std_logic
  		);
  end Entity;

architecture encoder_ts of QEncoder_ts is
  signal clk_i : std_logic := '0';
begin
  process         
    begin            
      --for i in 0 to 10000 loop
      clk_i <= not clk_i; 
      wait for 50 ns;    
      clk   <= clk_i;  
     --- end loop;    
     --- assert false report "end" severity failure;
  end process;

  Process
  	begin
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
          
        FOR i IN 0 TO 10 LOOP
	         a <= '1';
	         b <= '0';
	        wait for 100 ns;
	         a <= '1';
	         b <= '1';          
	        wait for 100 ns;
	         a <= '0';
	         b <= '1';
	        wait for 100 ns;
	         a <= '0';
	         b <= '0';
	        wait for 100 ns;
        END LOOP;
     
        FOR J IN 0 TO 10 LOOP
	         a <= '0';
	         b <= '1';
	        wait for 100 ns;
	         a <= '1';
	         b <= '1';          
	        wait for 100 ns;
	         a <= '1';
	         b <= '0';
	        wait for 100 ns;
	         a <= '0';
	         b <= '0';
	        wait for 100 ns;
        END LOOP;
    assert false report "end" severity failure;
	end process;

end architecture ; -- Q_en_ts