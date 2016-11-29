module clock_div_5k(CLOCK, clk);
	input  CLOCK;
	output clk;
	
	reg [16:0] count;
	reg clk;
	
	initial count = 0;
	
	always @ (posedge CLOCK) begin
			if (count > 5000) begin
				count <= 0;
				clk <= 1;
			end
			else begin
				count <= count + 1;
				clk <= 0;
			end
	end
endmodule