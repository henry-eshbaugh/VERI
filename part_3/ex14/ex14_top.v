module ex14_top (CLOCK_50, SW, DAC_SDI, HEX0, HEX1, HEX2, HEX3, HEX4, DAC_CS, DAC_SCK, DAC_LD, PWM_OUT);
	
	input  wire [9:0] SW;
	input wire CLOCK_50;
	output wire DAC_SDI, DAC_CS, DAC_SCK, DAC_LD, PWM_OUT;
	output wire [3:0] HEX0;
	output wire [3:0] HEX1;
	output wire [3:0] HEX2;
	output wire [3:0] HEX3;
	output wire [3:0] HEX4;
	
	wire [9:0] D;
	wire tick_10k;
	
	reg [9:0] A;
	
	clock_div_5k div5k (CLOCK_50, tick_10k);
	
	ROM mem (A, tick_10k, D);
	
	reg [23:0] to_bin2bcd;
	
	//const_mult x_10k (to_bin2bcd, SW, 14'd10000);
	
	wire [19:0] to_7seg;
	
	bin2bcd_16 bin_convert ({2'b00, to_bin2bcd[23:9]}, to_7seg[3:0], to_7seg[7:4], to_7seg[11:8], to_7seg[15:12], to_7seg[19:16]);
	
	hex_to_7seg out0 (HEX0, to_7seg[3:0]);
	hex_to_7seg out1 (HEX1, to_7seg[7:4]);
	hex_to_7seg out2 (HEX2, to_7seg[11:8]);
	hex_to_7seg out3 (HEX3, to_7seg[15:12]);
	hex_to_7seg out4 (HEX4, to_7seg[19:16]);
	
	spi2dac s2d (CLOCK_50, D, tick_10k, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	pwm     p   (CLOCK_50, D, tick_10k, PWM_OUT);
	
	always @ (posedge CLOCK_50) begin
		A <= A + SW;
		to_bin2bcd <= 14'd10000 * SW;
	end
		
endmodule

	
	