`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2020 11:23:54 AM
// Design Name: 
// Module Name: arith_alu_tb
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


module arith_alu_tb();
reg [3:0]a;
reg [3:0]b;
reg c_in;
reg [2:0]Op;
wire [3:0]out;
wire c_out;

arithmetic_alu L1(.a(a), .b(b), .c_in(c_in), .Op(Op), .out(out), .c_out(c_out));

initial begin
    a = 0;
    b = 0;
    Op = 0;
    c_in = 0;
end

always
    begin
        #10 {a,b,Op} = {a,b,Op} + 1;
        if ({a,b,Op} == 0) // only end after running through all a and b cases
            begin $finish;
        end
    end   
endmodule
