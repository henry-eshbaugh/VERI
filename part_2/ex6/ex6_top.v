module ex6_top (KEY, CLOCK_50, HEX0,HEX1,HEX2,HEX3,HEX4);

	parameter BIT_8 = 7;
	input [1:0] KEY;
	input CLOCK_50;
	
	output [BIT_8-1:0] HEX0;
	output [BIT_8-1:0] HEX1;
	output [BIT_8-1:0] HEX2;
	output [BIT_8-1:0] HEX3;
	output [BIT_8-1:0] HEX4;
	
	wire [15:0] count;
	
	wire en;
	wire clk;
	
	clock_div clk_div (CLOCK_50,clk);
	
	assign en = KEY[0]&clk;
	
	counter_16 a (CLOCK_50, en, count, ~KEY[1]);
	
	wire [19:0] BCD_OUT;
		
	bin2bcd_16 b (count,	BCD_OUT[3:0],	BCD_OUT[7:4],	BCD_OUT[11:8],	BCD_OUT[15:12],BCD_OUT[19:16]);
	
	hex_to_7seg hex0 (HEX0, BCD_OUT[3:0]);
	hex_to_7seg hex1 (HEX1, BCD_OUT[7:4]);
	hex_to_7seg hex2 (HEX2, BCD_OUT[11:8]);
	hex_to_7seg hex3 (HEX3, BCD_OUT[15:12]);
	hex_to_7seg hex4 (HEX4, BCD_OUT[19:16]);

endmodule
