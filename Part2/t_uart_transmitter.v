`timescale 1ns / 1ps

module t_uart_transmitter;

reg clk, reset;
reg [2:0] baud_select;
reg Tx_WR, Tx_EN;
wire Tx_BUSY;
reg [7:0] Tx_DATA;

uart_transmitter uTx(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);

initial 
begin
    	clk = 0;
    	reset = 1;
    	Tx_EN = 0;
    	Tx_WR = 0;
    	baud_select = 3'b011;

    	#100 reset = 0; 
    	Tx_EN = 1;
    	Tx_DATA = 8'b01111000;
    	Tx_WR = 1;
    	@(posedge Tx_BUSY) Tx_WR = 0;
    	#60000 $finish;
end

always #10 clk = ~clk;




endmodule
