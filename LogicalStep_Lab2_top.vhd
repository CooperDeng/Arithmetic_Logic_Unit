library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity LogicalStep_Lab2_top is port (
	pb					: in	std_logic_vector(6 downto 0); 	-- push buttons used for data input selection/operation control
 	sw   				: in  std_logic_vector(15 downto 0); 	-- The switch inputs used for data inputs
   leds				: out std_logic_vector(5 downto 0) 		--  leds for outputs
	
); 
end LogicalStep_Lab2_top;

architecture Circuit of LogicalStep_Lab2_top is

-- Declare any Components to be Used ---
------------------------------------------------------------------- 
 component hex_mux
 	port (
			hex_num3, hex_num2, hex_num1, hex_num0 : in std_logic_vector(3 downto 0);
			mux_select 										: in std_logic_vector(1 downto 0); 
			hex_out 											: out std_logic_vector(3 downto 0)
			);

 end component;
 
 component full_adder_4bit 
 	port (
			cin									: in std_logic;
			hex_val_A, hex_val_B				: in std_logic_vector(3 downto 0);
			hex_sum 								: out std_logic_vector(3 downto 0);
		   carry_out							: out std_logic
			);		

 end component;
 
 component logic_processor
	port (
			logic_in0, logic_in1 			: in std_logic_vector (3 downto 0);
			logic_select         			: in std_logic_vector (1 downto 0);
			logic_out  							: out std_logic_vector (3 downto 0)
		  );
 end component;
 
 component concatenation
	port (
		   one_bit_in							: in  std_logic;
			four_bit_in							: in  std_logic_vector (3 downto 0);
			five_bit_out						: out std_logic_vector (4 downto 0)
			);
 end component;
 
 component mux_out 
	port (
			input_A								: in  std_logic_vector (4 downto 0);
			input_B								: in  std_logic_vector (4 downto 0);
			mux_out_sel							: in  std_logic;
			mux_out_out							: out std_logic_vector (4 downto 0)
			);
 end component;
 
 
-- 
-------------------------------------------------------
-- Declare any signals here to be used within the design ---
-------------------------------------------------------
-- groups of logic signals with each group defined as std_logic_vector(MSB downto LSB)
	signal operand_A, operand_B, operand_C, operand_D		: std_logic_vector(3 downto 0);
	
-- output signal from hex_muxes
	signal hex_out1													: std_logic_vector(3 downto 0);
	signal hex_out2													: std_logic_vector(3 downto 0);

-- output signal from logic_processor
	signal logic_out													: std_logic_vector(3 downto 0);
	
-- output signal from full_adder_4bit
	signal hex_sum													   : std_logic_vector(3 downto 0);
	signal carry_out													: std_logic;
	
--- some mux_selector nets
	signal mux_sel1									: std_logic_vector(1 downto 0);
	signal mux_sel2									: std_logic_vector(1 downto 0);
	signal logic_sel									: std_logic_vector(1 downto 0);
	signal mux_out_sel								: std_logic;
	
-- concatenation zero signal
	signal con_zero									: std_logic;
	
-- concatenation output signal
	signal con_logic									: std_logic_vector(4 downto 0);
	signal con_adder									: std_logic_vector(4 downto 0);
	
-------------------------------------------------------------------
-------------------------------------------------------------------


begin


-- operands A to D
operand_A <= sw(3 downto 0);
operand_B <= sw(7 downto 4);
operand_C <= sw(11 downto 8);
operand_D <= sw(15 downto 12);



-- for the first hex_mux, but apperantly the lab manual refer it to the second mux, i'll still be using mux_sel1
-- because i feel comfortable using it.
mux_sel1 <= pb(1 downto 0);

-- for the second hex_mux, but apperantly the lab manual refer it to the first mux, i'll still be using mux_sel2
-- because i feel comfortable using it.
mux_sel2 <= pb(3 downto 2);

-- logical selection signal assignment
logic_sel<= pb(5 downto 4);

-- mux_out selection signal assignment
mux_out_sel <= pb(6);
leds(5) <= pb(6);

-- con_zero = '0'
con_zero <= '0';



----------------------------------------------------------------------------
-- PLACE your compnent instances below with the interconnection required ---
----------------------------------------------------------------------------

inst1: hex_mux port map (
								operand_D,operand_C,operand_B,operand_A,
								mux_sel1,
								hex_out1
								);

inst2: hex_mux port map (
								operand_D,operand_C,operand_B,operand_A,
								mux_sel2,
								hex_out2
								);

inst3: logic_processor port map(
								hex_out1, hex_out2,
								logic_sel,
								logic_out
							   );

inst4: full_adder_4bit port map (
								'0',
								hex_out1, hex_out2,
								hex_sum,
								carry_out
								);
								
inst5: concatenation port map(
								con_zero,
								logic_out,
								con_logic
								);

inst6: concatenation port map(
								carry_out,
								hex_sum,
								con_adder
								);

							
inst7: mux_out port map (
								con_logic,
								con_adder,
								mux_out_sel,
								leds(4 downto 0)
								);


end Circuit;

