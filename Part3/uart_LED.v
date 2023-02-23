`timescale 1ns / 1ps

module uart_LED(reset, clk, word, baud_select);

input reset, clk;
input [15:0] word;
input [2:0] baud_select;

reg [7:0] MS_byte;
reg [7:0] LS_byte;
reg [7:0] MS_data;
reg [7:0] LS_data;


reg [7:0] tr_data;
wire [7:0] re_data;

reg [15:0] data;
reg [6:0] LED;
reg [6:0] screen [3:0];
integer i;
integer indicator = 0;

wire Tx_BUSY, Rx_FERROR, Rx_PERROR, Rx_VALID, TxD;
reg Tx_WR, Tx_EN, Rx_EN;
integer ERROR = 0;

initial
begin
	#10;
	for(i = 0; i<4; i = i+1) screen[i] = 7'b1111111;
	MS_byte = word[15:8];
	LS_byte = word[7:0];
	Tx_WR = 1;
	Tx_EN = 1;
	Rx_EN = 1;
	tr_data = MS_byte;
end  


uart_transmitter uTx(reset, clk, tr_data, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);
uart_receiver uRx(reset, clk, re_data, baud_select, Rx_EN, TxD, Rx_FERROR, Rx_PERROR, Rx_VALID);


always @ (posedge Tx_BUSY)
begin
	Tx_WR = 0;
	Tx_EN = 0;
end

always @ (negedge Tx_BUSY) 
begin
	if(Rx_FERROR == 1 || Rx_PERROR == 1) ERROR = 1;
	if(tr_data == MS_byte)
	begin
		tr_data = LS_byte;
		MS_data = re_data;
	end
	else if(tr_data == LS_byte) LS_data = re_data;
	Tx_WR = 1;
	Tx_EN = 1;
	Rx_EN = 1;
end



always @ (MS_data, LS_data, ERROR)
begin
	if(ERROR == 1) data = 16'b1011_1011_1011_1011; //FFFF
	else data = {MS_data, LS_data};
end

anodeDriver led_driver(reset, clk, an3, an2, an1, an0, a, b, c, d, e, f, g, data);

always @ (negedge a, negedge b, negedge c, negedge d, negedge e, negedge f, negedge g)
begin
	LED = {a, b, c, d, e, f, g};
end

always @ (negedge an3, negedge an2, negedge an1, negedge an0)
begin
	if(an3 == 0) screen[3] = LED;
	else if(an2 == 0) screen[2] = LED;
	else if(an1 == 0) screen[1] = LED;
	else if(an0 == 0) screen[0] = LED;
end

always @ (screen[3], screen[2], screen[1], screen[0])
begin 
	$monitor("7-seg = %b, %b, %b, %b", screen[3], screen[2], screen[1], screen[0]);
end

endmodule
