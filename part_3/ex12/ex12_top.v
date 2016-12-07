module ex12_top (SW, CLOCK_50, HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);

	input [9:0] SW;
	
	wire [9:0] ROM_OUT;
	
	wire [19:0] BCD1;
	wire [19:0] BCD2;
	
	input CLOCK_50;
	
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	
	ROM mem (SW,CLOCK_50,ROM_OUT);
	
	bin2bcd_16 a ({6'b000000,SW},BCD1[3:0],BCD1[7:4],BCD1[11:8],BCD1[15:12],BCD1[19:16]);
	
	bin2bcd_16 b ({6'b000000,ROM_OUT},BCD2[3:0],BCD2[7:4],BCD2[11:8],BCD2[15:12],BCD2[19:16]);
	
	hex_to_7seg hex0 (HEX0, BCD2[3:0]);
	hex_to_7seg hex1 (HEX1, BCD2[7:4]);
	hex_to_7seg hex2 (HEX2, BCD2[11:8]);
	
	hex_to_7seg hex3 (HEX3, BCD1[3:0]);
	hex_to_7seg hex4 (HEX4, BCD1[7:4]);
	hex_to_7seg hex5 (HEX5, BCD1[11:8]);
	
endmodule