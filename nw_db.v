`timescale 1ns / 1ps

module nw_db(
input clk,
input bttn,
output bttn_out,
output reg [3:0] count = 4'b0000);

wire slw_clk;
wire Q1, Q2, Q2_bar;

clock_divider clk_div (.clk(clk), .divided_clk(slw_clk));

sm_ff d1 (.clk(slw_clk), .D(bttn), .Q(Q1));
sm_ff d2 (.clk(slw_clk), .D(Q1), .Q(Q2));

assign Q2_bar = ~Q2;
assign bttn_out = Q1 & Q2_bar;

always @(posedge slw_clk) 
    begin
    if (bttn_out == 1'b1)
    count <= count +1;
    else
    count <= count;
    end
    
endmodule