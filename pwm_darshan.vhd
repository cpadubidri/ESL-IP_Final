-------------------------------------------------
--- Author : Darshan & Asif
--- Function : PWM logic 
--- FileName : pwm.vhd
-------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity Pwm is
port( INA : out std_logic;
      INB : out std_logic;
      C   : out std_logic;
      clk : in std_logic;
      reset : in std_logic;
      enable : in std_logic;
      duty_cycle : in std_logic_vector (6 downto 0);
      direction : in std_logic_vector (1 downto 0)
    );
end entity;
--2500 is count for 20KHz
architecture behave of Pwm is
signal duty_i : integer;
    begin 
    process(clk,reset)
        variable ontime, offtime : integer := 0;
        variable counter: integer :=0;
        variable flag : integer range 0 to 1;
        begin       
            if(reset = '1') then
                C <= '0';
                counter:=0;
                flag:=1;
            elsif(rising_edge(clk)) then
             if(enable='1') then
                duty_i <= to_integer(unsigned(duty_cycle));
                ontime := (duty_i*25);
                offtime := 2500 - (duty_i * 25);
                counter:=0;
                flag:=1;
             end if;
             
             if(flag=1) then
             C<='1';
             counter:=counter+1;
             end if;
             
             if(counter = ontime and offtime /=0) then
             flag:=0;
             end if;
             
             if(flag=0) then
             C<='0';
             counter:=counter+1;
             end if;
            
            if(counter = 2500) then
            counter :=0;
            flag:=1;
            end if;
            
            
        end if;
      INA <= direction(1);
      INB <= direction(0);
    end process;
 end architecture;