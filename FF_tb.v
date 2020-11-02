`timescale 1ns / 1ps


module FF_tb();
    reg clk; //input slow clock
    reg D; //pushbutton input
    wire Q;
    wire Qbar;
 
 D_FF UUT (.clk(clk), .D(D), .Q(Q), .Qbar(Qbar));   
    
initial
begin
D <=0;
clk <=0;
end

always #5
begin
clk = ~clk;
end

always #50
begin
D = ~D;
end

endmodule
