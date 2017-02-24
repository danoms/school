-----------------------------
-- Author Toms Stūrmanis
-- Date	24.02.2017
-- Project name	Adder
-- Module name		n-bit adder
--
-- Detailed module description
--
--
-- Creates n-bit adder
-- Specify width when instantiate component
--
--
--
-- Revision:
-- A - initial design
-- B - 
--
-----------------------------

--synthesis library basic_arithmetic_blocks

library ieee;
use ieee.std_logic_1164.all;

library basic_bit_blocks;
use basic_bit_blocks.all;


entity adder is 
	generic
	(
		ADDER_WIDTH : integer 
	);
	port
	(
		clk	: in std_logic;
		a, b	: in std_logic_vector(ADDER_WIDTH-1 downto 0);
		
		cout	: out std_logic;
		q		: out std_logic_vector(ADDER_WIDTH-1 downto 0)
	);
	

end entity;

architecture slow of adder is
	
	component half_adder is 
	port
	(
		clk	: in std_logic;
		a		: in std_logic;
		b		: in std_logic;
		
		cout	: out std_logic;
		q		: out std_logic
	);
	end component;
	
	component full_adder is 
	port
	(
		clk	: in std_logic;
		cin	: in std_logic;
		a		: in std_logic;
		b		: in std_logic;
		
		cout	: out std_logic;
		q		: out std_logic
	);
	end component;
	
	signal cin : std_logic_vector(ADDER_WIDTH-1 downto 0);

begin
	sseg_0 : half_adder port map(clk, a(0), b(0), cin(0), q(0));
	
	gen_1 : for i in 1 to ADDER_WIDTH-1 generate
	
		gen_2 : 	if i < ADDER_WIDTH-1 generate
					sseg_i : full_adder port map(clk, cin(i-1),a(i), b(i), cin(i), q(i));
		end generate;
			  
		gen_3 : 	if i = ADDER_WIDTH-1 generate
					sseg_last : full_adder port map(clk, cin(i-1),a(i), b(i), cout, q(i));
		end generate;
	end generate;
	
end architecture;