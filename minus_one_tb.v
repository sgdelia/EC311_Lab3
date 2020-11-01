`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2020 11:12:54 AM
// Design Name: 
// Module Name: minus_one_tb
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


module minus_one_tb();
    reg [3:0] a;
    wire[3:0] out;
    
    minus_one UUT (.a(a), .out(out));
    
    initial begin
    a = 15;
    end
    always 
    begin 
       #10 {a} = {a} - 1;
       if (a == 4'b0000)
           begin $finish;
        end
    end
endmodule
