library ieee;

use ieee.std_logic_1164.all;

use 	work.types.all,
		work.constants.all;

entity instruction_decoder is
	generic ( reg_width : positive := reg_width_global );
		port
		(
			instruction_in : std_logic_vector(reg_width-1 downto 0);
			
			gpr_bus : out gpr_bus_type;
			
			sram_bus : out sram_bus_type;
			
			operation	: out operation_type
		);
end entity;

architecture nothing of instruction_decoder is
begin
end architecture;