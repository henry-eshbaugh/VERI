`timescale 1ns / 100ps //time in 1ns, resolution is 100ps

module counter_8 ( clock, enable,count, reset);
	parameter BIT_SZ = 16;
	input clock;
	input enable;
	input reset;
	output [BIT_SZ-1:0] count;
	
	reg [BIT_SZ-1:0] count;
	
	initial count = 0;
	
	always @ (posedge clock)
		if (enable == 1'b1)
			count <= count + 1'b1;
		if (reset == 1'b1)
			count <= 16'b0000000000000000;
endmodule
