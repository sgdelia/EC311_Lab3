`timescale 1ns / 1ps

module four_and(a, b, out);

input [3:0]a;
input [3:0]b;
output [3:0]out;

and zero(out[0], a[0], b[0]);
and one(out[1], a[1], b[1]);
and two(out[2], a[2], b[2]);
and three(out[3], a[3], b[3]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?