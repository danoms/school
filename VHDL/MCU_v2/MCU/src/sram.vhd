library ieee;

use ieee.std_logic_1164.all;

use 	work.types.all,
		work.constants.all;

entity sram is
	generic ( reg_width : positive := reg_width_global );
		port
		(
			clk	: in std_logic;
			rst 	: in std_logic;
		
			sram_bus 	: in sram_bus_type;
			
			data_inout 	: inout std_logic_vector(reg_width-1 downto 0)
		
		);
end entity;

architecture nothing of sram is
begin
end architecture;