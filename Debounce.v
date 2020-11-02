`timescale 1ns / 1ps

module Debounce (
    input button,
    input CLK100MHZ,
    output button_LED,
    output temp,
    output temp2
    //,
    //output reg [3:0] count = 0
    );
    
    wire clk_out, tQ1,tQ2,tQ1_bar, tQ2_bar, t;
    reg Q1, Q2, Q1_bar, Q2_bar;
    
    clock_divider clk (.clk(CLK100MHZ), .divided_clk(clk_out));
    
    D_FF D1 ( .clk(clk_out), .D(button), .Q(tQ1), .Qbar(tQ1_bar));
    
    D_FF D2 (.D(tQ1), .clk(clk_out), .Q(tQ2), .Qbar(tQ2_bar));
    
    assign temp = tQ1;
    assign temp2 = tQ2_bar;
    
    and a1 (t, tQ1, tQ2_bar);
    
    
    assign button_LED = t;
    /*
    assign tQ1 = Q1;
    assign tQ2 = Q2;
    assign tQ1_bar = Q1_bar;
    assign tQ2_bar = Q2_bar;
    
    always @(*)
    begin
    if ((Q1 != 0) | (Q1 != 1))
        assign Q1 = 0;
    end
    
    always @(*)
    begin
    if ((Q2 != 0) | (Q2 != 1))
        assign Q2 = 0;
    end
    always @(*)
    begin
    if ((Q1_bar != 0) | (Q1_bar != 1))
        assign Q1_bar = 0;
    end
    
    always @(*)
    begin
    if ((Q2_bar != 0) | (Q2_bar != 1))
        assign Q2_bar = 0;
    end
    */
    

    
    
    /*always @(posedge clk_out) //make into a case statement with button down = 1 increase count by 1
    begin
    if (button_LED == 1)
    count <= count +1;
    else
    count <= count;
    end*/ 
    
endmodule
