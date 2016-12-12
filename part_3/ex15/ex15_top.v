module ex15_top (CLOCK_50, HEX0, HEX1, HEX2, HEX3,
						DAC_SDI, DAC_SCK, DAC_CS, DAC_LD,
						ADC_SDI, ADC_SCK, ADC_CS, ADC_SDO, PWM_OUT);

						
	output wire		ADC_SDI;			//Serial data out to SDI of the ADC
	output wire		ADC_SCK;		// ADC Clock signal
	output wire		ADC_CS;			//Chip select to the ADC, low active
	input wire		ADC_SDO;			//Converted serial data from ADC	
		
	wire			tick_10k;		// internal clock at 10kHz
	wire [9:0] 	data_in;		// converted data from ADC
	wire			data_valid;
						
	input wire CLOCK_50;
	output wire DAC_SDI, DAC_CS, DAC_SCK, DAC_LD, PWM_OUT;
	output wire [3:0] HEX0, HEX1, HEX2, HEX3;

	
	wire [9:0] D;
	
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
	spi2adc SPI_ADC (												// perform a A-to-D conversion
		.sysclk (CLOCK_50), 										// order of parameters do not matter
		.channel (1'b0), 											// use only CH1
		.start (tick_10k),
		.data_from_adc (data_in),
		.data_valid (data_valid),
		.sdata_to_adc (ADC_SDI),
		.adc_cs (ADC_CS),
		.adc_sck (ADC_SCK),
		.sdata_from_adc (ADC_SDO));		
	

	always @ (posedge CLOCK_50) begin
		A <= A + data_in[9:6];
		to_bin2bcd <= 14'd10000 * data_in[9:6];
	end
		
endmodule