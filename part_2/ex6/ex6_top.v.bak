module ex6_top (KEY, CLOCK_50, HEX0,HEX1,HEX2,HEX3,HEX4);

	parameter BIT_8 = 7;
	input KEY;
	input CLOCK_50;
	
	output [BIT_8-1:0] HEX0;
	output [BIT_8-1:0] HEX1;
	output [BIT_8-1:0] HEX2;
	output [BIT_8-1:0] HEX3;
	output [BIT_8-1:0] HEX4;
	
	wire [15:0] count;
	
	counter_16 a (CLOCK_50, !KEY[0], count, !KEY[1]);
	
	wire [19:0] BCD_OUT;
	
	bin2bcd_16 b (count,
						BCD_OUT[0:3],
						BCD_OUT[4:7],
						BCD_OUT[8:11],
						BCD_OUT[12:15],
						BCD_OUT[16:19]);
	
	hex_to_7seg hex0 (BCD_OUT[0:3],HEX0);
	hex_to_7seg hex1 (BCD_OUT[4:7],HEX1);
	hex_to_7seg hex2 (BCD_OUT[8:11],HEX2);
	hex_to_7seg hex3 (BCD_OUT[12:15],HEX3);
	hex_to_7seg hex4 (BCD_OUT[16:19],HEX4);

endmodule
