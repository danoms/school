library ieee;

use ieee.std_logic_1164.all;

use 	work.types.all,
		work.constants.all;

entity arithmetic_logic_unit is
	generic ( reg_width : positive := reg_width_global );
		port
		(
			clk 	: in std_logic;
			rst 	: in std_logic;
			
			alu_a 		: in std_logic_vector(reg_width-1 downto 0);
			alu_b 		: in std_logic_vector(reg_width-1 downto 0);
			operation	: in operation_type;
			
			rd		: out std_logic_vector(reg_width-1 downto 0);
			flags	: out std_logic_vector(flags_width-1 downto 0)
		);
end entity;

architecture nothing of arithmetic_logic_unit is
begin
end architecture;