-----------------------------
-- Author Toms Stūrmanis
-- Date	24.02.2017
-- Project name	Adder
-- Module name		Full adder
--
-- Detailed module description
--
--
-- Takes in account carry in 
-- from previous bit adder
-- and sums accordingly
--
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------

--synthesis library basic_bit_blocks

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
	port
	(
		clk	: in std_logic;
		cin	: in std_logic;
		a		: in std_logic;
		b		: in std_logic;
		
		cout	: out std_logic;
		q		: out std_logic
	);
	

end entity;

architecture logic_gates_only of full_adder is

	signal a_and_c, a_and_b, b_and_c : std_logic;
	
begin
	
	
	q 		<= a xor b xor cin;
	cout  <= a_and_b or a_and_c or b_and_c;
	
end architecture;


architecture logic_gates_only_clk of full_adder is

	signal a_and_c, a_and_b, b_and_c : std_logic;
	
begin
	
	count_on_rising_clk : process(clk)
	begin
		if rising_edge(clk) then
			q 		<= a xor b xor cin;
			cout  <= a_and_b or a_and_c or b_and_c;
		end if;
	end process;
	
end architecture;