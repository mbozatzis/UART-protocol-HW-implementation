`timescale 1ns / 1ps

module t_anodeDriver;

reg clk, reset;
reg [15:0] word;

anodeDriver test (reset, clk, an3, an2, an1, an0, a, b, c, d, e, f, g, word); // instatiate decoder test

initial begin

	clk = 0; // our clock is initialy set to 0
	reset = 1; // our reset signal is initialy set to 1

	#100; // after 100 timing units, i.e. ns
					
	reset = 0; // set reset signal to 0

	#200 word = 16'b1010_0001_1001_0100;
	#1000 word = 16'b1100_1100_0001_0000;
	#1000 word = 16'b1010_1100_0011_0010;
	#1000 word = 16'b1011_1011_1011_1011;
					
	#10000 $finish;	 // after 10000 timing units, i.e. ns, finish our simulation
end
	
always #10 clk = ~ clk; // create our clock, with a period of 20ns







endmodule
