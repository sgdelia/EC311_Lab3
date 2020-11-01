`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2020 08:48:46 PM
// Design Name: 
// Module Name: cla_adder
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


module cla_adder(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] sum,
    output cout
    );
wire [3:0] p,g;
wire [4:0] c;

assign p = a^b;
assign g = a&b;

cla_block main (p,g,cin,c);

assign sum = p ^ c [3:0];
assign cout = c[4];
endmodule

module cla_block (
    input [3:0] p,g,
    input cin,
    output [4:0] c
    );

assign c[0] = cin;
assign c[1] = g[0] | (p[0] & cin);
assign c[2] = g[1] | (p[1]&g[0]) |  (p[1]&p[0]&cin);
assign c[3] = g[2] | (p[2]&g[1]) | (p[2]&p[1]&g[0]) | (p[2]&p[1]&p[0]&cin);
assign c[4] = g[3] | (p[3]&g[2]) | (p[3]&p[2]&g[1]) | (p[3]&p[2]&p[1]&g[0]) | (p[3]&p[2]&p[1]&p[0]&cin);
endmodule
