library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MuxTestBench is
	-- test bench has no ports
end MuxTestBench; 

architecture behavioral of MuxTestBench is
	component Mux PORT (
		clk : IN STD_LOGIC;
		a	: IN STD_LOGIC_VECTOR (7 downto 0);
		b	: IN STD_LOGIC_VECTOR (7 downto 0);
		s	: IN STD_LOGIC;
		x 	: OUT STD_LOGIC_VECTOR (7 downto 0)
	);
	end component;

	-- inputs
	signal clk	: STD_LOGIC;
	signal s	: STD_LOGIC;
	signal a	: STD_LOGIC_VECTOR (7 downto 0);
	signal b	: STD_LOGIC_VECTOR (7 downto 0);
	signal x 	: STD_LOGIC_VECTOR (7 downto 0);

	begin
	mux_component: Mux Port map(clk=>clk,a=>a, b=>b, s=>s, x=>x);

	-- clock process ( 1 MHZ clock => period of 1000ns)
	clk_process: process 
	begin
		while true loop
			clk <= '0';
			wait for 500 ns; -- half of period
			clk <= '1';
			wait for 500 ns;
		end loop;
	end process;
	
	TestHarness: process
		begin

		wait for 500 ns;
		-- tc 0
		a <= "10101010";
		b <= "11110000";
		s <= '0';

		wait for 1000 ns;

		s <= '1';

		wait for 1000 ns;

		s <= '0';
		
		wait for 10000 ns;
	end process;
end behavioral;				

