`timescale 1ns / 1ps

module t_uart_receiver;

reg clk, reset;
reg [2:0] baud_select;
wire Rx_FERROR, Rx_PERROR, Rx_VALID;
reg Rx_EN;
wire [7:0] Rx_DATA;
reg RxD;

uart_receiver uRx(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD, Rx_FERROR, Rx_PERROR, Rx_VALID);

initial 
begin
    	clk = 0;
    	reset = 1;
    	Rx_EN = 0;
    	baud_select = 3'b111;
    	RxD = 0;

    	#100 reset = 0; 
    	Rx_EN = 1;
    	#60000 $finish;
end

always #10 clk = ~clk;
always #500 RxD = ~RxD; 






endmodule

