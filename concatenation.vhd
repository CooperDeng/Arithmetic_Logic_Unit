library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity concatenation is
	port (
		   one_bit_in				: in  std_logic;
			four_bit_in				: in  std_logic_vector (3 downto 0);
			five_bit_out			: out std_logic_vector (4 downto 0)
			);
end concatenation;

architecture circuit of concatenation is


begin

	five_bit_out <= one_bit_in & four_bit_in;
	
end circuit;