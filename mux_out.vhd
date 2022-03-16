library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity mux_out is
	port (
	input_A								: in  std_logic_vector (4 downto 0);
	input_B								: in  std_logic_vector (4 downto 0);
	mux_out_sel							: in  std_logic;
	mux_out_out							: out std_logic_vector (4 downto 0)
	);
end mux_out;

architecture mux_out_logic of mux_out is

begin
	
	with mux_out_sel select
	mux_out_out <= (input_A) when '0',
						(input_B) when '1';

end mux_out_logic;