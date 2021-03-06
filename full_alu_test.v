`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2020 10:21:50 AM
// Design Name: 
// Module Name: full_alu_test
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


module full_alu_test();

reg [3:0]a;
reg [3:0]b;
reg c_in;
reg [2:0]Op;
reg mode;
wire [3:0]out;
wire c_out;


full_alu f1(.a(a), .b(b), .c_in(c_in), .Op(Op), .mode(mode), .out(out), .c_out(c_out));

initial begin
    a = 0;
    b = 0;
    Op = 0;
    mode = 0;
    c_in = 0;
end

always
    begin
        #10 {a,b,Op, mode} = {a,b,Op, mode} + 1;
        if ({a,b,Op, mode} == 0) // only end after running through all a and b cases
            begin $finish;
        end
    end   

endmodule
