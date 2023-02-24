`timescale 1ns / 1ps

module encoder(reset, clk, input_data, output_data, key);

input reset, clk;
input [7:0] input_data;
input [3:0] key;

output reg [7:0] output_data;


always @ (posedge clk, posedge reset)
begin
	if(reset) output_data = 8'b0000_0000;
	else
	begin
		output_data = ~input_data;
		output_data = output_data + key;
	end
end
endmodule
