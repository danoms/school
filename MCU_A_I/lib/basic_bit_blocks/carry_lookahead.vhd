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

--synthesis library basic_bit_blocks

entity carry_lookahead is
	generic
	(
		INPUT_WIDTH : natural 
	);
	port
	(
		a, b 	: in std_logic_vector(INPUT_WIDTH-1 downto 0);
		cin 	: in std_logic;
		
		cin_i	: out std_logic_vector(INPUT_WIDTH)
	);
end entity;

