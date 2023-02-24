`timescale 1ns / 1ps

module t_uart_LED_coding;

reg clk, reset;
reg [2:0] baud_select;
reg [15:0] word;
reg [3:0] key;


uart_LED_coding uartLEDc(reset, clk, word, baud_select, key);


initial 
begin
    	clk = 0;
    	reset = 1;
    	baud_select = 3'b110;
	word = 16'b1010_0001_1001_0100;
	key = 4'b0011;

    	#100 reset = 0; 
    	#60000 $finish;
end

always #10 clk = ~clk;


endmodule
