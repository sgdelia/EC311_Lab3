`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2020 03:53:39 PM
// Design Name: 
// Module Name: multiplier_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiplier_tb();
    
    reg [3:0]a;
    reg [3:0]b;
    wire [7:0] p;
    wire c_out;


multiplier multi1(
.a(a), 
.b(b),
.p(p),
.c_out(c_out)
);

//Simple Test
initial begin
    a = 0;
    b = 0;
end
    always 
    begin 
       #10 {a,b} = {a,b} + 1;
        if ({a,b} == 0)
            begin $finish;
        end
    end
endmodule
