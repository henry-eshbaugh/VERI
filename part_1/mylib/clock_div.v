module clock_div(CLOCK, clk);
	input  CLOCK;
	output clk;
	
	reg [16:0] count;
	reg clk;
	
	initial count = 0;
	
	always @ (posedge CLOCK) begin
			count <= count + 1;
			clk <= 0;
			if (count > 50000) begin
				count <= 0;
				clk <= 1;
			end
	end
endmodule
