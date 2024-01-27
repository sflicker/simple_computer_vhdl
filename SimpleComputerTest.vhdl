library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SimpleComputerTest is
end SimpleComputerTest;

architecture Behavioral of SimpleComputerTest is
	component DataRegister
		Port (		
			data_in      : in STD_LOGIC_VECTOR(7 downto 0);
        	clk          : in STD_LOGIC;
        	reset        : in STD_LOGIC;
        	enable_write : in STD_LOGIC;
        	data_out     : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end Component;
	
	component Memory is
		Port (
        clk             : in STD_LOGIC;
        addr            : in STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit-address
        data_in         : in STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit- data input
        enable_write    : in STD_LOGIC;   --enable write
        data_out        : out STD_LOGIC_VECTOR(7 downto 0)  -- 8 bit data output
		);
	end Component;

	component Mux is
		Port (
		clk : IN STD_LOGIC;
		a   : IN STD_LOGIC_VECTOR (7 downto 0);
		b   : IN STD_LOGIC_VECTOR (7 downto 0);
		s	: IN STD_LOGIC;
		x 	: OUT STD_LOGIC_VECTOR (7 downto 0) 
		);
	end Component;

	signal clk, reset, enable_write_a, enable_write_b, enable_write_mem  : STD_LOGIC;
	signal addr : STD_LOGIC_VECTOR(7 downto 0);
	signal data_bus_out : STD_LOGIC_VECTOR(7 downto 0);
	signal data_bus_in : STD_LOGIC_VECTOR(7 downto 0);
	signal register_select : STD_LOGIC;
	signal reg_A_out, reg_B_out : STD_LOGIC_VECTOR(7 downto 0);
begin
	-- instantiate Registers A and B
	regA : DataRegister
		port Map ( 
			clk => clk, 
			reset => reset, 
			enable_write => enable_write_a, 
			data_in => data_bus_out, 
			data_out => reg_A_out
		);

	regB : DataRegister
		port Map (
			clk => clk,
			reset => reset,
			enable_write => enable_write_b,
			data_in => data_bus_out,
			data_out => reg_B_out
		);

	dataMemory : Memory
		Port Map (
			clk => clk,
			addr => addr,
			data_in => data_bus_in,
			enable_write => enable_write_mem,
			data_out => data_bus_out	
		);

	registerMux : Mux
		Port Map (
			clk => clk,
			a => reg_A_out,
			b => reg_B_out,
			s => register_select,
			x => data_bus_in
		);

	clk_process : process
	begin
		clk <= '0';
		wait for 500 ns;
		clk <= '1';
		wait for 500 ns;
	end process;

	stim_proc : process
	begin
		-- initialize
		reset <= '1';
		wait for 1000 ns;
		reset <= '0';
		enable_write_a <= '0';
		enable_write_b <= '0';
		enable_write_mem <= '0';
		addr <= (others => '0');
		data_bus_in <= (others => '0');
		data_bus_out <= (others => '0');
		
		wait for 1000 ns;
		data_bus_out <= "10001000";
		enable_write_a <= '1';
		wait for 1000 ns;

		-- write to memory
		addr <= "00000001";
		enable_write_mem <= '1';

		wait for 1000 ns;


		-- 
		enable_write_b <= '1';
		wait for 1000 ns;

		wait for 5000 ns;

	end process;

end Behavioral;

