module ex11_top(SW, CLOCK_50, DAC_CS, DAC_SDI, DAC_LD, DAC_SCK, PWM_OUT);
		input [9:0] SW;
		input CLOCK_50;
		output DAC_CS, DAC_SDI, DAC_LD, DAC_SCK, PWM_OUT;
		
		wire load_10k;
		wire [9:0] SW;
		wire DAC_CS, DAC_SDI, DAC_LD, DAC_SCK;
		
		clock_div_5k cd5k (CLOCK_50, load_10k);
		spi2dac s2d (CLOCK_50, SW[9:0], load_10k, DAC_SDI, DAC_CS, DAC_SCK, DAC_LD);
		pwm p (CLOCK_50, SW[9:0], load_10k, PWM_OUT);
endmodule
