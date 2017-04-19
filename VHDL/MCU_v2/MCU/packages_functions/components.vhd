library ieee;

use ieee.std_logic_1164.all;

use 	work.constants.all,
		work.types.all;

package components is 
	--memory elements
	component program_flash is
		generic ( reg_width : positive := reg_width_global );
		port
		(
			clk 	: in std_logic;
			rst 	: in std_logic;
			
			program_count 			: in std_logic_vector(reg_width-1 downto 0);
			
			instruction_out 		: out std_logic_vector(reg_width-1 downto 0)
		);
	end component;
	
	component sram is
		generic ( reg_width : positive := reg_width_global );
		port
		(
			clk	: in std_logic;
			rst 	: in std_logic;
		
			sram_bus 	: in sram_bus_type;
			
			data_inout 	: inout std_logic_vector(reg_width-1 downto 0)
		
		);
	end component;

	--logic elements
	component instruction_decoder is
		generic ( reg_width : positive := reg_width_global );
		port
		(
			instruction_in : std_logic_vector(reg_width-1 downto 0);
			
			gpr_bus : out gpr_bus_type;
			
			sram_bus : out sram_bus_type;
			
			operation	: out operation_type
		);
	end component;
	
	component general_purpose_register is
		generic ( reg_width : positive := reg_width_global );
		port
		(
			clk 	: in std_logic;
			rst 	: in std_logic;

			gpr_bus : in gpr_bus_type;
			
			alu_a 	: out std_logic_vector(reg_width-1 downto 0);
			alu_b 	: out std_logic_vector(reg_width-1 downto 0)
		);
	end component;
	
	component arithmetic_logic_unit is
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
	end component;
	
	
	
end package;