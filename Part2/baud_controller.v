`timescale 1ns / 1ps

module baud_controller(reset, clk, baud_select, sample_ENABLE);

input reset, clk;
input [2:0] baud_select;
output reg sample_ENABLE;

real baud_rate, Ts;
real Tclk = 20; // time in ns
integer n; // couter max value
integer counter = 0;

always @(baud_select)
begin
    case(baud_select)
        3'b000: baud_rate = 300;
        3'b001: baud_rate = 1200;
        3'b010: baud_rate = 4800;
        3'b011: baud_rate = 9600;
        3'b100: baud_rate = 19200;
        3'b101: baud_rate = 38400;
        3'b110: baud_rate = 57600;
        3'b111: baud_rate = 115200;
    endcase

    Ts = (1/(16*baud_rate)) * (10 ** 9); // time in ns
    if($ceil(Ts/Tclk)-Ts/Tclk > Ts/Tclk - $floor(Ts/Tclk)) n = $floor(Ts/Tclk);
    else n = $ceil(Ts/Tclk); 
end

always @(posedge clk, posedge reset)
begin
    if(reset == 1) sample_ENABLE = 0;
    else if(counter == n)
    begin
        sample_ENABLE = 1; 
        counter = 0;
    end
    else sample_ENABLE = 0;

    counter = counter + 1;
end

endmodule
