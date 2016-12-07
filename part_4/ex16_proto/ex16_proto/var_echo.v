module processor (sysclk, data_in, data_out, data_valid, var_in);

	input				sysclk;		// system clock
	input [9:0]		data_in;		// 10-bit input data
	output [9:0] 	data_out;	// 10-bit output data
	input wire		data_valid;  		// 10kHz pulse

	wire				sysclk;
	wire [9:0]		data_in;
	reg [9:0] 		data_out;
	wire 				pulse;
	
	wire [9:0]		y, x;

	parameter 		ADC_OFFSET = 10'h181;
	parameter 		DAC_OFFSET = 10'h200;

	assign x = data_in[9:0] - ADC_OFFSET;		// x is input in 2's complement
	
	
	//........................//
	
	wire [8:0] q;
	
	pulse_gen pg (pulse, data_valid, sysclk);
	
	RAM ram_echo (.clock(sysclk), .data(y[9:1]), .rdaddress(rdaddr), .rden(pulse), .wraddress(wdaddr), .wren(pulse), .q(q));
	
	input wire [9:0] var_in;
	wire [12:0] switches;
	
	assign switches = {var_in[8:0],1'b0,1'b0,1'b0,1'b0};
	
	wire [12:0] wdaddr;
	
	assign wdaddr = rdaddr + switches;
	
	wire [12:0] rdaddr;
	
	counter_13 counter (data_valid, 1'b1, rdaddr, 1'b0); 
	
	assign y = x - {q[8],q[8:1]};
	

	//........................//
	
	
	//  Now clock y output with system clock
	always @(posedge sysclk)
		data_out <=  y + DAC_OFFSET;
		
endmodule
	