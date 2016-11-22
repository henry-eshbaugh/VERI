module ex3_top (SW,HEX0,HEX1,HEX2);
	input [9:0] SW;
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	
	wire[3:0] hex2input;
	assign hex2input[3:2] = 0;
	assign hex2input[1:0] = SW[9:8];
	
	hex_to_7seg a (HEX0, SW[3:0]);
	hex_to_7seg b (HEX1, SW[7:4]);
	hex_to_7seg c (HEX2, hex2input);
	
endmodule
