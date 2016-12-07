module processor (sysclk, data_in, data_out, pulse);

	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	output [9:0] 	data_out;	// 10-bit output data
	input 			pulse;  		// 10kHz pulse

	wire				sysclk;
	wire [9:0]		data_in;
	reg [9:0] 		data_out;
	wire 				pulse;
	
	wire [9:0]		y, x,z,a;

	parameter 		ADC_OFFSET = 10'h181;
	parameter 		DAC_OFFSET = 10'h200;

	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement
	
	
	//........................//
	
	FIFO fifo (.clock(sysclk), .data(x), .rdreq(read), .wrreq(pulse), .full(full_out), .q(a));
		
	reg 		full;
	wire 		full_out;
	
	always @ (posedge sysclk)
		full <= full_out;

	assign	z = a >>> 1;
	
	assign	y = x + z;
		
	wire 		read;
	
	assign 	read = full & pulse;
	

	//........................//
	
	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		data_out <=  y + DAC_OFFSET;
		
endmodule
	