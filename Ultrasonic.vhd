library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UltraSonic is
Port ( clk        : in  STD_LOGIC;
trig : out STD_LOGIC;
echo : in  STD_LOGIC;
count1 : out  STD_LOGIC_vector(3 downto 0));
end UltraSonic;

architecture Behavioral of UltraSonic is
signal count            : unsigned(16 downto 0) := (others => '0');
signal centimeters      : unsigned(15 downto 0) := (others => '0');
signal centimeters_ones : unsigned(3 downto 0)  := (others => '0');
signal centimeters_tens : unsigned(3 downto 0)  := (others => '0');
signal output_ones      : unsigned(3 downto 0)  := (others => '0');
signal output_tens      : unsigned(3 downto 0)  := (others => '0');
signal echo_last        : std_logic := '0';
signal echo_synced      : std_logic := '0';
signal echo_unsynced    : std_logic := '0';
signal waiting          : std_logic := '0'; 
signal echo_time			: integer;
type state1 is (a0,a1);   
signal ps1 : state1 := a0;
signal s_count:std_logic_vector(3 downto 0);
begin
  process(clk)
    variable c1,c2: integer:=0;
    variable y :std_logic:='1';
  begin
    if rising_edge(clk) then

        if(c1=0) then
            trig<='1';
        elsif(c1=500) then--100us
            trig<='0';
            y:='1';
        elsif(c1=5000000) then-- 100 ms
            c1:=0;
            trig<='1';
        end if;
        c1:=c1+1;

        if(echo = '1') then
            c2:=c2+1;
        elsif(echo = '0' and y='1' ) then-- I change the y to not get echo_time =0;
            echo_time<= c2;
            c2:=0;
            y:='0';
        end if;

--        if(echo_time < 100000) then--20 cm
--            motor<="10";
--        elsif(echo_time > 150000)then--30 cm
--            motor<="01";
--        else-- between  
--            motor<="11";
--        end if;
    end if; 
end process ;
end Behavioral; 