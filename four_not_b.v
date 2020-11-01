
`timescale 1ns / 1ps

module four_not_b(b, out);

input [3:0]b;
output [3:0]out;

not  zero(out[0], b[0]);
not one(out[1], b[1]);
not two(out[2], b[2]);
not three(out[3], b[3]);

endmodule
// When 0000 and 0000 at end, get 1111. Why?