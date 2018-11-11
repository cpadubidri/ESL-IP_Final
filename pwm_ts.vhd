library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_ts is 
  Port(
       clk       : out std_logic;
       reset     : out std_logic;
       enable    : out std_logic;
       dutycycle : out std_logic_vector(7 downto 0);
       dir       : out std_logic_vector(1 downto 0) 
      );
end entity;

architecture testset of pwm_ts is
  signal clk_i : std_logic := '0';
begin
      process         
        Begin            
          --for i in 0 to 10000 loop
          clk_i <= not clk_i; 
          wait for 50 ns;    
          clk   <= clk_i;  
         --- end loop;    
         --- assert false report "end" severity failure;
      end process;
      
      
      process
      variable a : integer ; 
        begin
          reset <= '1';
          wait for 100 ns;
          reset <= '0';
          
          dir <= "01";
          
          enable <= '1';
          wait for 200 ns;
          a := 75;
          dutycycle <= std_logic_vector(to_signed(a, dutycycle'length));
          wait for 200 ns;
          enable <= '0';
          wait for 1 ms;
          
          enable <= '1';
          wait for 200 ns;
          a := 50;
          dutycycle <= std_logic_vector(to_unsigned(a, dutycycle'length));
          wait for 200 ns;
          enable <= '0';
          wait for 1 ms;
          
          enable <= '1';
          wait for 200 ns;
          a := 25;
          dutycycle <= std_logic_vector(to_unsigned(a, dutycycle'length));
          wait for 200 ns;
          enable <= '0';
          wait for 1 ms;
          
          --enable <= '1';
          --wait for 200 ns;
          --a := 0;
          --dutycycle <= std_logic_vector(to_unsigned(a, dc'length));
          --wait for 200 ns;
          --enable <= '0';
          --wait for 1 ms;
          
          
          assert false report "end" severity failure;
      end process;
      
end architecture;      
          
  
