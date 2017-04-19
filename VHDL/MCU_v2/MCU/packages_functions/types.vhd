library ieee;

use ieee.std_logic_1164.all;

use work.constants.all;

package types is
	type operation_type is (add, subtract, shift_l, shift_r, andd, orr);
	
	type reg_type is record
		program_counter 			: std_logic_vector(reg_width_global-1 downto 0);
		stack_pointer				: std_logic_vector(reg_width_global-1 downto 0);
		instruction_register		: std_logic_vector(reg_width_global-1 downto 0);
		return_register			: std_logic_vector(reg_width_global-1 downto 0);
		status_register 			: std_logic_vector(reg_width_global-1 downto 0);
	end record;
	
	type gpr_bus_type is record
		addr_rd 		: std_logic_vector(reg_width_global-1 downto 0);
		addr_rs1		: std_logic_vector(reg_width_global-1 downto 0);
		addr_rs2 	: std_logic_vector(reg_width_global-1 downto 0);
		rd 			: std_logic_vector(reg_width_global-1 downto 0);
	end record;
	
	type sram_bus_type is record
		write_en		: std_logic;
		addr	 		: std_logic_vector(reg_width_global-1 downto 0);
	end record;
	
	type alu_bus_type is record
		alu_a 		: std_logic_vector(reg_width_global-1 downto 0);
		alu_b 		: std_logic_vector(reg_width_global-1 downto 0);
		operation	: operation_type;
	end record;
--	type control_lines_type is record
--		
--	end record;
end package;