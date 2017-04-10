library ieee;

use ieee.std_logic_1164.all;

package instructions is

--data processing instructions
	type opcode is (	op_AND, EOR, SUB, RSB,
							ADD, ADC, SBC, RSC,
							TST, TEQ, CMP, CMN,
							ORR, MOV, BIC, MVN);
							
	

end package;