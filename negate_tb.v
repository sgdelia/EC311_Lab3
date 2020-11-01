`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 11:48:21 AM
// Design Name: 
// Module Name: negate_tb
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


module negate_tb();
    reg [3:0] a;
    wire[3:0] out;
    
    negate UUT (.a(a), .out(out));
    
    initial begin
    a = 0;
    end
    always 
    begin 
       #10 {a} = {a} + 1;
       if (a == 4'b1111)
           begin $finish;
        end
    end

endmodule
