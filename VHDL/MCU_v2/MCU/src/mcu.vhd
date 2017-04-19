library ieee;

use 	ieee.std_logic_1164.all,
		ieee.numeric_std.all;

use 	work.components.all,
		work.constants.all,
		work.types.all;

entity mcu is 
	generic (reg_width : positive := reg_width_global);
	port 
	(
		clk 	: in std_logic;
		rst	: in std_logic
--		en		: in std_logic
	);
end entity;

architecture simple of mcu is 
	signal r, rin 				: reg_type;
	
	signal gpr_bus_signal 	: gpr_bus_type;
	signal sram_bus_signal	: sram_bus_type; 
	
	signal operation 				: operation_type;
	signal alu_a, alu_b, rd 	: std_logic_vector(reg_width-1 downto 0); 
	signal flags 					: std_logic_vector(flags_width-1 downto 0);
	
	signal count_en 	: std_logic := '1';
begin

	process (clk, rst)
	begin
		if rst then 
			r.program_counter <= (others => '0');
		elsif rising_edge(clk) then
			r <= rin;
			if count_en then 
				r.program_counter <= std_logic_vector(unsigned(r.program_counter) + 1);
			end if;
		end if;
	end process;

	program_flash_1 : component program_flash 
		port map
		(
			clk 	=> clk,
			rst 	=> rst,
			
			program_count 		=>	r.program_counter,
			
			instruction_out 	=> rin.instruction_register
		);

	instruction_decoder_1 : component instruction_decoder
		port map
		(
			instruction_in => r.instruction_register,
			
			gpr_bus 			=> gpr_bus_signal,
			
			sram_bus 		=> sram_bus_signal,
			
			operation		=> operation
		);
	
	general_purpose_register_1 : component general_purpose_register
		port map
		(
			clk 		=> clk,
			rst 		=> rst,

			gpr_bus 	=> gpr_bus_signal,
			
			alu_a 	=> alu_a,
			alu_b 	=> alu_b
		);
		
	arithmetic_logic_unit_1 : component arithmetic_logic_unit
		port map
		(
			clk 	=> clk,
			rst 	=> rst,
			
			alu_a 		=> alu_a,
			alu_b 		=> alu_b,
			operation	=> operation,
			
			rd		=> gpr_bus_signal.rd,
			flags	=> rin.status_register(flags_width-1 downto 0)
		);
	
	sram_1 : component sram
		port map
		(
			clk			=> clk,
			rst 			=> rst,
		
			sram_bus 	=> sram_bus_signal,
			
			data_inout 	=> gpr_bus_signal.rd
		
		);
	
end architecture;