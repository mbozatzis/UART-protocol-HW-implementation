`timescale 1ns / 1ps

module t_baud_controller;

reg clk, reset;
reg [2:0] baud_select;
wire sample_ENABLE;

baud_controller baudCont(reset, clk, baud_select, sample_ENABLE);

initial 
begin
    	clk = 0;
	reset = 1;
    	baud_select = 3'b011; //6510

	#100 reset = 0;
    	#8000 baud_select = 3'b101; //1628
    	#20000 $finish;
end

always #10 clk = ~clk;




endmodule

