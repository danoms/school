library ieee;

use ieee.std_logic_1164.all;

use 	work.types.all,
		work.constants.all;
		
entity program_flash is
	generic ( reg_width : positive := reg_width_global );
		port
		(
			clk 	: in std_logic;
			rst 	: in std_logic;
			
			program_count 			: in std_logic_vector(reg_width-1 downto 0);
			
			instruction_out 		: out std_logic_vector(reg_width-1 downto 0)
		);
end entity;

architecture nothing of program_flash is
begin
end architecture;