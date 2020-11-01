`timescale 1ns / 1ps

module Debounce (
    input button,
    input CLK100MHZ,
    output wire button_LED
    //,
    //output reg [3:0] count = 0
    );
    
    wire clk_out;
    wire Q1, Q2,Q1_bar, Q2_bar;
    
    clock_divider clk (.clk(CLK100MHZ), .divided_clk(clk_out));
    
    D_FF D1 (.D(button), .clk(clk_out), .Q(Q1), .Qbar(Q1_bar));
    
    D_FF D2 (.D(Q1), .clk(clk_out), .Q(Q2), .Qbar(Q2_bar));
    
    and a1 (button_LED, Q1, Q2_bar);

    
    
    /*always @(posedge clk_out) //make into a case statement with button down = 1 increase count by 1
    begin
    if (button_LED == 1)
    count <= count +1;
    else
    count <= count;
    end*/ 
    
endmodule
