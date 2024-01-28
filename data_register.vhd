library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataRegister is
	Generic (
		ID : string 	-- adding an identifier
	);
    Port (
		data_in      : in STD_LOGIC_VECTOR(7 downto 0);
        clk          : in STD_LOGIC;
        reset        : in STD_LOGIC;
        enable_write : in STD_LOGIC;
        data_out     : out STD_LOGIC_VECTOR(7 downto 0)
	);
end DataRegister;

architecture Behavioral of DataRegister is
begin
	process(clk, reset)
	begin
		if reset = '1' then
			report "DataRegister Reset";
			data_out <= (others => '0');
			
		elsif rising_edge(clk) then
			if enable_write = '1' then
				report "DataRegister instance " & ID & " data_in=" & to_string(data_in);
				data_out <= data_in;
			end if;
		end if;
	end process;
end Behavioral;
	
