`timescale 1ns / 1ps

module uart_transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);

input reset, clk;
input [2:0] baud_select;
input [7:0] Tx_DATA;
input Tx_WR;
input Tx_EN;

output reg TxD;
output reg Tx_BUSY;

wire Tx_sample_ENABLE;
integer counter = -1;


baud_controller baud_controller(reset, clk, baud_select, Tx_sample_ENABLE);

always @ (posedge Tx_sample_ENABLE, posedge reset)
begin
	if(reset)
    	begin
        	TxD = 1;
        	Tx_BUSY = 0;
    	end   

    	if(Tx_EN == 1 && Tx_WR == 1) Tx_BUSY = 1;

    	if(Tx_BUSY)
    	begin
        	counter = counter + 1;
        	if(counter == 0) TxD = 0; // Start bit
        	else if(counter >= 1 && counter <= 8) TxD = Tx_DATA[counter-1];
        	else if(counter == 9) TxD = ~^ Tx_DATA; // Parity bit
        	else if (counter == 15) 
        	begin
            		counter = -1;
            		Tx_BUSY = 0;
        	end
        	else TxD = 1;
    	end  
	//$monitor("counter = %d, TxD = %b",counter, TxD);  
end

endmodule
