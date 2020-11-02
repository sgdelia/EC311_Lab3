`timescale 1ns / 1ps

module db_tb();
reg button;
reg CLK100MHZ;
wire button_LED;
wire t1, t2;
//wire [3:0] count = 0;
Debounce UUT (.button(button), .CLK100MHZ(CLK100MHZ), .button_LED(button_LED),.temp(t1), .temp2(t2));

initial
begin
button <=0;
CLK100MHZ <= 0;
end

always #5
begin
CLK100MHZ = ~CLK100MHZ;
end

always #50
begin
button = ~button;
end


endmodule