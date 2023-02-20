`timescale 1ns / 1ps

module t_LEDdecoder;

reg clk, reset;
reg [3:0] char;
wire [6:0] LED;

LEDdecoder test (char,LED); // instatiate decoder test

initial begin

	clk = 0; // our clock is initialy set to 0
	reset = 1; // our reset signal is initialy set to 1

	#100; // after 100 timing units, i.e. ns
					
	reset = 0; // set reset signal to 0
					
	#10000 $finish;	 // after 10000 timing units, i.e. ns, finish our simulation
end
	
always #10 clk = ~ clk; // create our clock, with a period of 20ns

always@(posedge clk)
begin
	#20 char = 4'b0000;	// 0
	#20 char = 4'b0001;	// 1
	#20 char = 4'b0011;	// 3
	#20 char = 4'b0010;	// 2
	#20 char = 4'b0110;	// 6
	#20 char = 4'b0111;	// 7
	#20 char = 4'b0101;	// 5
	#20 char = 4'b0100;	// 4
	#20 char = 4'b1100;	// 12
	#20 char = 4'b1010;	// 10
	#20 char = 4'b1011;	// 11
	#20 char = 4'b1001;	// 9
	#20 char = 4'b1000;	// 8
end

endmodule
