library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package body Utils is
    function to_hex_string(byte : std_logic_vector(7 downto 0)) return string is
        constant hex_chars : string := "0123456789ABCDEF";
        variable high_nibble : integer;
        variable low_nibble : integer;
    begin
        high_nibble := to_integer(unsigned(byte(7 downto 4)));
        low_nibble := to_integer(unsigned(byte(3 downto 0)));
        return hex_chars(high_nibble+1) & hex_chars(low_nibble+1);
    end function;
end Utils;