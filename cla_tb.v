`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2020 09:44:47 PM
// Design Name: 
// Module Name: cla_tb
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


module cla_tb();
reg [3:0]a;
reg [3:0]b;
reg cin;
wire [3:0]sum;
wire cout;


cla_adder cla1(
.a(a), 
.b(b),
.cin(cin),
.sum(sum),
.cout(cout)
);

//Simple Test
initial begin
    a = 0;
    b = 0;
    cin = 0;
end
    always 
    begin 
       #10 {a,b} = {a,b} + 1;
        if ({a,b} == 0)
            begin $finish;
        end
    end
endmodule