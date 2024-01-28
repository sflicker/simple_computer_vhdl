library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity DataRegisterTestBench is
	-- test bench has no ports
end DataRegisterTestBench;

architecture behavioral of DataRegisterTestBench is

    component DataRegister is
	 Port (
        data_in      	: in STD_LOGIC_VECTOR(7 downto 0);
        clk          	: in STD_LOGIC;
        reset        	: in STD_LOGIC;
        enable_write 	: in STD_LOGIC;
        data_out     	: out STD_LOGIC_VECTOR(7 downto 0)
	);
    end component;

	signal clk			: STD_LOGIC := '0';
	signal reset		: STD_LOGIC := '0';
	signal enable_write	: STD_LOGIC := '0';
	signal data_in		: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal data_out		: STD_LOGIC_VECTOR(7 downto 0);

begin

	uut:	DataRegister
		port map (
			clk => clk,
			reset => reset,
			enable_write => enable_write,
			data_in => data_in,
			data_out => data_out
		);

	clk_process : process
	begin
		while true loop
			clk <= '0';
			wait for 500 ns; -- half period
			clk <= '1';
			wait for 500 ns; -- half period
		end loop;
	end process;

	stim_proc: process
	begin

		-- initialize inputs
		reset <= '1';
		enable_write <= '0';
		data_in <= (others => '0');

		-- apply reset
		wait for 2000 ns;
		reset <= '0';
		wait for 1000 ns;

		-- test case 1: write and hold data
		enable_write <= '1';
 		data_in <= "10101010"; -- example data
		wait for 1000 ns;
		enable_write <= '0';

		-- test case 2; change data while write is disabled
		data_in <= "11001100";
		wait for 1000 ns;

		-- test case 3: re-enable write with new data
		enable_write <= '1';
		wait for 1000 ns;
		enable_write <= '0';

		-- complete testing
		wait;

	end process;
end Behavioral;

