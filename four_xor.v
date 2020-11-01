`timescale 1ns / 1ps

module four_xor(a, b, out);

input [3:0]a;
input [3:0]b;
output [3:0]out;

xor  zero(out[0], a[0], b[0]);
xor one(out[1], a[1], b[1]);
xor two(out[2], a[2], b[2]);
xor three(out[3], a[3], b[3]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?