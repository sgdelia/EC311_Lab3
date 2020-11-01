`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ian Chadwick
// 
// Create Date: 10/11/2020 01:50:22 PM
// Design Name: 4-bit ALU
// Module Name: multiplier
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


module multiplier(
    //user input
    input [3:0] a,
    input [3:0] b,
    //product in 8-bits
    output [7:0] p,
    //signifies overflow on 4 bit ALU
    output reg c_out
    );
    
    //set up wires to hold values of partial products
    wire [3:0] pp0, pp1, pp2, pp3, pp4, pp5;
    //wires to for carry out of first two additions and carry in
    wire cout0, cout1, cin;
    //wires to hold the sums of first two additions
    wire [3:0] sum1, sum2;
    //set carry in to 0
    assign cin = 0;
    initial begin
    c_out <= 1'b0;
    end
    
    //outputs directly to p[0]
    assign p[0] = a[0] & b[0];
    
    //first input to first addition
    and (pp0[0], a[1],b[0]);
    and (pp0[1], a[2],b[0]);
    and (pp0[2], a[3],b[0]);
    assign pp0[3]= 0;
    
    //second input to first addition
    and (pp1[0], a[0],b[1]);
    and (pp1[1], a[1],b[1]);
    and (pp1[2], a[2],b[1]);
    and (pp1[3], a[3],b[1]);
    
    //first addition
    cla_adder a1(.a(pp0),.b(pp1), .sum(sum1), .cin(cin), .cout(cout0));
    //output directly to p[1]
    assign p[1] = sum1[0];
    
    //first input to second addition
    assign pp2[0] = sum1[1];
    assign pp2[1] = sum1[2];
    assign pp2[2] = sum1[3];
    assign pp2[3] = cout0; 
    
    //second input to second addition
    and (pp3[0], a[0],b[2]);
    and (pp3[1], a[1],b[2]);
    and (pp3[2], a[2],b[2]);
    and (pp3[3], a[3],b[2]);
    
    //second addition
    cla_adder a2(.a(pp2),.b(pp3), .sum(sum2), .cin(cin), .cout(cout1));
    //output directly to p[2]
    assign p[2] = sum2[0];
    
    //first input to third addition
    assign pp4[0] = sum2[1];
    assign pp4[1] = sum2[2];
    assign pp4[2] = sum2[3];
    assign pp4[3] = cout1; 
    
    //second input to third addition
    and (pp5[0], a[0],b[3]);
    and (pp5[1], a[1],b[3]);
    and (pp5[2], a[2],b[3]);
    and (pp5[3], a[3],b[3]);
    
    //third addition addition
    cla_adder a3(.a(pp4),.b(pp5), .sum(p[6:3]), .cin(cin), .cout(p[7]));
    
    //checks to see if bits 4-7 are 1 in which case show overflow with c_out for main system
    always @(*) begin
    if (p[4] == 1'b1)
    c_out <= p[4];
    else if (p[5] == 1'b1)
    c_out <= p[5];
    else if (p[6] == 1'b1)
    c_out <= p[6];
    else if (p[7] == 1'b1)
    c_out <= p[7];
    else
    c_out <= 1'b0;
    end
    
endmodule