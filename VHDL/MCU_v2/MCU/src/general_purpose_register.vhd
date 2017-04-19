library ieee;

use ieee.std_logic_1164.all;

use 	work.types.all,
		work.constants.all;

entity general_purpose_register is
	generic ( reg_width : positive := reg_width_global );
		port
		(
			clk 	: in std_logic;
			rst 	: in std_logic;

			gpr_bus : in gpr_bus_type;
			
			alu_a 	: out std_logic_vector(reg_width-1 downto 0);
			alu_b 	: out std_logic_vector(reg_width-1 downto 0)
		);
end entity;

architecture nothing of general_purpose_register is
begin
end architecture;