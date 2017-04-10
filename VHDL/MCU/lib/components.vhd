--! Use standard library
library ieee;
--! Use logic elements
	use ieee.std_logic_1164.all;

--! Package of all used components in top entity. Parts list.
package components is 
--! Arithmetic Logic Unit
	component ALU is
		port
		(
			a 				: in std_logic_vector;  --! variable a
			b 				: in std_logic_vector;  --! variable b
			op 			: in opcode; 				--! choose operation
			
			flags 		: out std_logic_vector; --! sets flags
			ressult 		: out std_logic_vector	--! final result
		);
	end component;

--! General Purpose Register 
	component GPR is
		port
		(
			Rd_addr 	: in std_logic_vector;
			Rm_addr	: in std_logic_vector;
			Rn_addr 	: in std_logic_vector;
			
			
			alu_ress 	: in std_logic_vector;
			
			a : out std_logic_vector;
			b : out std_logic_vector
		);
	end component;
	
end package;