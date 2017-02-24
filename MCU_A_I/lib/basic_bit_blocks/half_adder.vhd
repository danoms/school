-----------------------------
-- Author Toms Stūrmanis
-- Date	24.02.2017
-- Project name	Adder
-- Module name		Half adder
--
-- Detailed module description
--
--
-- Sums bits a and b
-- Overflowed bit is carry out
--
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

entity half_adder is 
	port
	(
		clk	: in std_logic;
		a		: in std_logic;
		b		: in std_logic;
		
		cout	: out std_logic;
		q		: out std_logic
	);
	

end entity;

architecture logic_gates_only of half_adder is

begin
	
	q		<= a xor b;
	cout  <= a and b;
	
end architecture;



architecture logic_gates_only_clk of half_adder is

begin
	
	count_on_rising_clk : process(clk)
	begin
		if rising_edge(clk) then
			q 		<= a xor b;
			cout  <= a and b;
		end if;
	end process;
	
end architecture;