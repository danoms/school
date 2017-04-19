library ieee;

use ieee.std_logic_1164.all;

package constants is
	constant reg_width_global 			: positive := 4;
	constant flags_width 				: positive := 4;
	
	constant instruction_reg_width 	: positive := 16;
	constant status_reg_width 			: positive := 16;
end package;