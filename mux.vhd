library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux is
	Generic (
		ID : string 	-- adding an identifier
	);
	PORT(
		clk : IN STD_LOGIC;
		a   : IN STD_LOGIC_VECTOR (7 downto 0);
		b   : IN STD_LOGIC_VECTOR (7 downto 0);
		s	: IN STD_LOGIC;
		x 	: OUT STD_LOGIC_VECTOR (7 downto 0) 
	) ;
end mux;

architecture behavior of mux is
BEGIN
    process(clk)
    begin
	if rising_edge(clk) then
		if s = '1' then
			report "Mux Setting Output to input A value " & to_string(a);
			x <= a;
		else
			report "Mux setting output to input B value " & to_string(b);
			x <= b;
		end if;
	end if;
	end process;
end behavior;

