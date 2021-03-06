-----------------------------
-- Author Toms Stūrmanis
-- Date	24.02.2017
-- Project name	Homework
-- Module name		everything
--
-- Detailed module description
--
--
-- lets add!!!
-- 
--
--
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------


library ieee;
use ieee.std_logic_1164.all;

library basic_arithmetic_blocks;
use basic_arithmetic_blocks.all;

entity all_homeworks is
	generic
	(
		INPUT_WIDTH : natural := 8
	);
	port
	(
		clk 	: in std_logic;
		a, b	: in std_logic_vector(INPUT_WIDTH-1 downto 0);
		
		q 		: out std_logic_vector(INPUT_WIDTH-1 downto 0)
	);
	

end entity;

architecture whatever of all_homeworks is

--	component adder 
--	generic
--	(
--		ADDER_WIDTH : integer 
--	);
--	port
--	(
--		clk	: in std_logic;
--		a, b	: in std_logic_vector(ADDER_WIDTH-1 downto 0);
--		
--		cout	: out std_logic;
--		q		: out std_logic_vector(ADDER_WIDTH-1 downto 0)
--	);
--	end component;
	

begin

	adder_1 : entity basic_arithmetic_blocks.adder(slow) generic map
	(
		ADDER_WIDTH => INPUT_WIDTH
	)
	port map
	(
		clk 	=> clk,
		a		=> a,
		b 		=> b,
		q		=> q
	); 
	
--	adder_2 : entity adder(logic_gates_only_short) generic map
--	(
--		ADDER_WIDTH => INPUT_WIDTH
--	)
--	port map
--	(
--		clk 	=> clk,
--		a		=> a,
--		b 		=> b,
--		q		=> q
--	); 

end architecture;