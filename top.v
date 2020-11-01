`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2020 11:47:35 AM
// Design Name: 
// Module Name: top
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

// This was just example code to demonstrate what is up
// We don't use it, but it's a nice reference
module top(
    input wire CLK100MHZ,
    input wire RST_BTN, // center of buttons
    output wire VGA_HS_O, // horizontal sync
    output wire VGA_VS_O, // vertical sync
    output wire [3:0] VGA_R, // 4 bit red output
    output wire [3:0] VGA_G, // 4 bit green output
    output wire [3:0] VGA_B // 4 bit blue output
    );
    
    wire rst = RST_BTN; // Reset is active high on my FPGA, could be different on school's
    
    // Generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge CLK100MHZ)
        {pix_stb,cnt} <= cnt + 16'h4000; // Divide by 4: (2^16)/4 = 0x4000
        
    wire [9:0] x; // current pixel x position: 10 bit value 0-1023
    wire [8:0] y; // current y position: 9 bit value 0-512
    
    vga640x480 display(
        .i_clk(CLK100MHZ),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O),
        .o_vs(VGA_VS_O),
        .o_x(x),
        .o_y(y)
    );
    
    // Make a red square
    wire square_zero, square_one, square_two, square_three;
    assign square_zero = ((x > 0) & (y > 0) & (x < 150) & (y < 110)) ? 1 : 0; // look up what that means
    assign square_one = ((x > 155) & (y > 115) & (x < 305) & (y < 225)) ? 1 : 0; // look up what that means
    assign square_two = ((x > 310) & (y > 230) & (x < 460) & (y < 335)) ? 1 : 0; // look up what that means
    assign square_three = ((x > 465) & (y > 340) & (x < 615) & (y < 450)) ? 1 : 0; // look up what that means
endmodule

// Source: https://timetoexplore.net/blog/arty-fpga-vga-verilog-01
