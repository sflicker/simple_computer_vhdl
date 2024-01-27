library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Memory_TB is
-- test bench has no ports
end Memory_TB;

architecture Behavioral of Memory_TB is

	 -- component declaration
 	component Memory is 
		Port (
        clk             : in STD_LOGIC;
        addr            : in STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit-address
        data_in         : in STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit- data input
        enable_write    : in STD_LOGIC;   --enable write
        data_out        : out STD_LOGIC_VECTOR(7 downto 0)  -- 8 bit data output
        );
	end component;

	-- signal declaration
	signal clk				: STD_LOGIC := '0';
	signal addr				: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal data_in			: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal enable_write		: STD_LOGIC := '0';
	signal data_out			: STD_LOGIC_VECTOR(7 downto 0);

begin
	-- instantiate the unit under test (UUT)
	uut: Memory
		port map (
			clk => clk,
			addr => addr,
			data_in => data_in,
			enable_write => enable_write,
			data_out => data_out
		);

	-- clock process (1 MHz clock => period of 1000ns)
	clk_process : process
	begin
		while true loop
			clk <= '0';
			wait for 500 ns; -- half of period
			clk <= '1';
			wait for 500 ns;
		end loop;
	end process;

	stim_proc: process
	begin
		-- test case 1 write data to memory
		addr <= "00000001"; -- example address
		data_in <= "10101010"; -- example data
		enable_write <= '1';  -- enable write

		wait for 1000 ns;

		enable_write <= '0';
		wait for 1000 ns;

		-- test case 2 read from the same memory location
		addr <= "00000001";
		wait for 1000 ns;

		wait for 5000 ns;
	end process;
end Behavioral;

			
