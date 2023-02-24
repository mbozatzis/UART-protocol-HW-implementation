`timescale 1ns / 1ps

module t_decoder;

reg clk, reset;
reg [7:0] input_data;
reg [3:0] key;
wire [7:0] output_data;

decoder test(reset, clk, input_data, output_data, key);

initial 
begin
	clk = 0; 
	reset = 1; 
	input_data = 8'b1110_1100;
	key = 4'b0011;


	#100; 			
	reset = 0; 				
	#10000 $finish;	 
end
	
always #10 clk = ~ clk; 



endmodule
