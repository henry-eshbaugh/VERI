module ex13_top (CLOCK_50, PWM_OUT, DAC_LD, DAC_CS,DAC_SCK,DAC_SDI);

	input CLOCK_50;
	
	output PWM_OUT;
	output DAC_LD;
	output DAC_CS;
	output DAC_SCK;
	output DAC_SDI;
	
	wire load_10k;

	wire [9:0] A;
	
	wire [9:0] D;

	clock_div_5k cd5k (CLOCK_50, load_10k);
	
	counter_10 counter (CLOCK_50,load_10k,A,1'b0);
	
	ROM mem (A[9:0],CLOCK_50,D[9:0]);
	
	spi2dac s2d (CLOCK_50, D[9:0], load_10k, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
	
	pwm p (CLOCK_50, D[9:0], load_10k, PWM_OUT);
	
endmodule
