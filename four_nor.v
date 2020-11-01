`timescale 1ns / 1ps

module four_nor(a, b, out);

input [3:0]a;
input [3:0]b;
output [3:0]out;

nor zero(out[0], a[0], b[0]);
nor one(out[1], a[1], b[1]);
nor two(out[2], a[2], b[2]);
nor three(out[3], a[3], b[3]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?