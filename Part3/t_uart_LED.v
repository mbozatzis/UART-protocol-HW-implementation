`timescale 1ns / 1ps

module t_uart_LED;

reg clk, reset;
reg [2:0] baud_select;
reg [15:0] word;


uart_LED uartLED(reset, clk, word, baud_select);


initial 
begin
    	clk = 0;
    	reset = 1;
    	baud_select = 3'b110;
	word = 16'b1010_0001_1001_0100;

    	#100 reset = 0; 
    	#60000 $finish;
end

always #10 clk = ~clk;


endmodule