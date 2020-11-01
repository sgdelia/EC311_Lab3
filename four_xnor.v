`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2020 10:58:12 AM
// Design Name: 
// Module Name: four_xnor
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

`timescale 1ns / 1ps

module four_xnor(a, b, out);

input [3:0]a;
input [3:0]b;
output [3:0]out;

xnor  zero(out[0], a[0], b[0]);
xnor one(out[1], a[1], b[1]);
xnor two(out[2], a[2], b[2]);
xnor three(out[3], a[3], b[3]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?