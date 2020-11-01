`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 06:22:45 PM
// Design Name: 
// Module Name: BCD_tb
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


module BCD_tb();

    reg [3:0] binary;
    wire[3:0] tens;
    wire[3:0] ones;
    
    BCD UUT (.binary(binary), .tens(tens), .ones(ones));
    
    initial begin
    binary = 0;
    end
    always 
    begin 
       #10 {binary} = {binary} + 1;
       if (binary == 4'b1111)
           begin $finish;
        end
    end

endmodule
