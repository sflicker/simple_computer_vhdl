library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--library work;
--use work.Utils.all;

entity SimpleComputerTest is
end SimpleComputerTest;

architecture Behavioral of SimpleComputerTest is
	-- component DataRegister
	-- 	Port (		
	-- 		data_in      : in STD_LOGIC_VECTOR(7 downto 0);
    --     	clk          : in STD_LOGIC;
    --     	reset        : in STD_LOGIC;
    --     	enable_write : in STD_LOGIC;
    --     	data_out     : out STD_LOGIC_VECTOR(7 downto 0)
	-- 	);
	-- end Component;
	
	-- component Memory is
	-- 	Port (
    --     clk             : in STD_LOGIC;
    --     addr            : in STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit-address
    --     data_in         : in STD_LOGIC_VECTOR(7 downto 0);  -- 8-bit- data input
    --     enable_write    : in STD_LOGIC;   --enable write
    --     data_out        : out STD_LOGIC_VECTOR(7 downto 0)  -- 8 bit data output
	-- 	);
	-- end Component;

	-- component Mux is
	-- 	Port (
	-- 	clk : IN STD_LOGIC;
	-- 	a   : IN STD_LOGIC_VECTOR (7 downto 0);
	-- 	b   : IN STD_LOGIC_VECTOR (7 downto 0);
	-- 	s	: IN STD_LOGIC;
	-- 	x 	: OUT STD_LOGIC_VECTOR (7 downto 0) 
	-- 	);
	-- end Component;

	signal clk, reset, enable_write_a, enable_write_b, enable_write_mem  : STD_LOGIC;
	signal addr : STD_LOGIC_VECTOR(7 downto 0);
	signal memory_out : STD_LOGIC_VECTOR(7 downto 0);
	signal memory_in : STD_LOGIC_VECTOR(7 downto 0);
	signal register_direct_data_in : STD_LOGIC_VECTOR(7 downto 0); 
	signal register_data_in : STD_LOGIC_VECTOR(7 downto 0);
	signal memory_in_register_select : STD_LOGIC;
	signal register_in_source_select : STD_LOGIC;
	signal reg_A_out, reg_B_out : STD_LOGIC_VECTOR(7 downto 0);
begin
	-- instantiate Registers A and B
	regA : entity work.DataRegister
		generic map (
			ID => "RegA"
		)
		port Map ( 
			clk => clk, 
			reset => reset, 
			enable_write => enable_write_a, 
			data_in => register_data_in, 
			data_out => reg_A_out
		);

	regB : entity work.DataRegister
		generic map (
			ID => "RegB"
		)
		port Map (
			clk => clk,
			reset => reset,
			enable_write => enable_write_b,
			data_in => register_data_in,
			data_out => reg_B_out
		);

	dataMemory : entity work.Memory
		generic Map (
			ID => "DataMemory"
		)
		Port Map (
			clk => clk,
			addr => addr,
			data_in => memory_in,
			enable_write => enable_write_mem,
			data_out => memory_out	
		);

	registerOutputMux : entity work.Mux
		generic Map (
			ID => "RegisterOutputMux"
		)
		Port Map (
			clk => clk,
			a => reg_A_out,
			b => reg_B_out,
			s => memory_in_register_select,
			x => memory_in
		);

	registerInputMux : entity work.Mux
		generic Map (
			ID => "RegisterInputMux"
		)
		Port Map (
			clk => clk,
			a => memory_out,
			b => register_direct_data_in,
			s  => register_in_source_select,
			x => register_data_in
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
		Report "Resetting";
		reset <= '1';
		wait for 1000 ns;

		Report "Initializing";
		reset <= '0';
		enable_write_a <= '0';
		enable_write_b <= '0';
		enable_write_mem <= '0';
		addr <= (others => '0');
		addr <= "00000001";
--		memory_in <= (others => '0');
--		memory_out <= (others => '0');
		register_direct_data_in <= (others => '0');
		memory_in_register_select <= '1';
		
		wait for 1000 ns;

		-- Here is the test description
		-- write a value directly into Register A
		-- Write the value in Register A to memory Location 1.
		-- Write the value of memory location 1 to Register B
		Report "Starting Test";
		Report "Preparing to Write Value 01 to Memory register A using direct data in";
		register_direct_data_in <= "00000001";
		register_in_source_select <= '0';
		enable_write_a <= '1';
		enable_write_b <= '0';
		Report "Wait for next clock cycle";
		wait for 1000 ns;
		Report "Output After clock cycle. register_data_in=" & to_hex_string(register_data_in) & ", enable_write_a=" & to_string(enable_write_a) & ",  reg_A_out=" & to_hex_string(reg_A_out);
		
		Report "Wait for next clock cycle";
		wait for 1000 ns;
		Report "Output After clock cycle. register_data_in=" & to_hex_string(register_data_in) & ", enable_write_a=" & to_string(enable_write_a) & ",  reg_A_out=" & to_hex_string(reg_A_out);

		Report "Select A register output Location 1";
		-- write data in regiter A to memory location 1
		enable_write_a <= '0';
		memory_in_register_select <= '1';
		Report "Wait fo next clock cycle";
		wait for 1000 ns;

		Report "Write to memory location";
		addr <= "00000001";
		enable_write_mem <= '1';
		wait for 1000 ns;

		Report "Value in Memory Out Location " & to_hex_string(memory_out);

		Report "Preparing to Write Value in Memory Location 1 to Register B";
		-- write data in memory location 1 to Register B
		enable_write_mem <= '0';
		register_in_source_select <= '1';
		Report "Wait for next clock cycle";
		wait for 1000 ns;

		enable_write_b <= '1';
		wait for 1000 ns;

		wait for 1000 ns;

		wait for 1000 ns;
		Report "Output of Register B after clock - " & to_hex_string(reg_B_out);
		enable_write_b <= '0';

-- 		Report "Settings values to write to B register";
-- --		memory_out <= "00000010";
-- 		register_direct_data_in <= "00000010";
-- 		enable_write_a <= '0';
-- 		enable_write_b <= '1';

-- 		-- write to memory
-- 		Report "settings values to write Register A to memory location 1";
-- 		addr <= "00000001";
-- 		enable_write_mem <= '1';
-- 		memory_in_register_select <= '1';

-- 		wait for 1000 ns;

-- 		-- 
-- 		Report "settings values to write Register B to memory Location 2";
-- 		memory_in_register_select <= '0';
-- 		addr <= "00000010";
-- 		wait for 1000 ns;

		wait for 10000 ns;
		report "Finished";
	end process;

end Behavioral;

