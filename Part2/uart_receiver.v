`timescale 1ns / 1ps

module uart_receiver(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD, Rx_FERROR, Rx_PERROR, Rx_VALID);

input reset, clk;
input [2:0] baud_select;
input Rx_EN;
input RxD;

output reg Rx_FERROR, Rx_PERROR, Rx_VALID;
output reg [7:0] Rx_DATA;

wire Rx_sample_ENABLE;
reg Rx_START = 0;
reg parity;
integer counter = -1;

baud_controller baud_controller(reset, clk, baud_select, Rx_sample_ENABLE);

always @ (negedge RxD) if(counter == -1) 
begin
    	Rx_START = 1;
    	Rx_FERROR = 0;
    	Rx_PERROR = 0;
	Rx_VALID = 0;
end

always @ (posedge Rx_sample_ENABLE)
begin
    	if(Rx_EN && Rx_START)    
    	begin
        	counter = counter + 1;
		if(counter == 0)
		begin
			if(RxD == 0) 
			begin
				Rx_VALID = 1;
				Rx_FERROR = 0;
			end
			else
			begin
				Rx_VALID = 0;
				Rx_FERROR = 1;
			end
		end
        	else if(counter >= 1 && counter <= 8) Rx_DATA[counter-1] = RxD;
        	else if(counter == 9) 
        	begin
            		parity = RxD; 
            		if(parity == ~^Rx_DATA)
            		begin
                		Rx_VALID = 1;
                		Rx_PERROR = 0;
            		end
            		else
            		begin
                		Rx_VALID = 0;
                		Rx_PERROR = 1;
            		end
        	end
		else if(counter == 10)
		begin
			if(RxD == 0) 
			begin
				Rx_VALID = 0;
				Rx_FERROR = 1;
			end
		end
        	else if (counter == 15) 
        	begin
            		counter = -1;
            		Rx_START = 0;
        	end
        	//$monitor("counter = %d, TxD = %b",counter, Rx_DATA[counter-1]);
    	end    
end


endmodule
