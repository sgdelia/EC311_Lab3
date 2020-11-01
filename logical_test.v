`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2020 12:01:38 PM
// Design Name: 
// Module Name: logical_test
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


module logical_test();
reg [3:0]a;
reg [3:0]b;
reg c_in;
reg [2:0]Op;
wire [3:0]out;
wire c_out;

logical_alu L1(.a(a), .b(b), .c_in(c_in), .Op(Op), .out(out), .c_out(c_out));

initial begin
    a = 0;
    b = 0;
    Op = 0;
end

always
    begin
        #10 {a,b,Op} = {a,b,Op} + 1;
        if ({a,b,Op} == 0) // only end after running through all a and b cases
            begin $finish;
        end
    end   
endmodule
