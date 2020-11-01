`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2020 01:20:29 PM
// Design Name: 
// Module Name: output_squares
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
// This is the actual squares display
// Uses the setup from vga640x480
// Counter tutorial
// http://users.wpi.edu/~rjduck/Counter%20Tutorial%20Verilog.pdf

module output_squares(
    input [3:0]ALU_in,
    input wire CLK100MHZ,
    output wire VGA_HS_O, // horizontal sync
    output wire VGA_VS_O, // vertical sync
    output reg [3:0]VGA_R, // 4 bit red output for zero
    output reg [3:0]VGA_G // 4 bit green output for one
    );
    
    
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
    
    wire square_zero, square_one, square_two, square_three;
    assign square_three = ((x > 0) & (y > 0) & (x < 150) & (y < 110)) ? 1 : 0; // top left square
    assign square_two = ((x > 155) & (y > 115) & (x < 305) & (y < 225)) ? 1 : 0; // middle left square
    assign square_one = ((x > 310) & (y > 230) & (x < 460) & (y < 335)) ? 1 : 0;  // middle right square
    assign square_zero = ((x > 465) & (y > 340) & (x < 615) & (y < 450)) ? 1 : 0; // bottom right square
    
    always @ (posedge CLK100MHZ) begin
    
        case(ALU_in[3])
            1'b1 : VGA_G[3] <= square_three;
            1'b0 : VGA_R[3] <=square_three;
            default : VGA_R[3] <= square_three;
        endcase
        case(ALU_in[2])
            1'b1 : VGA_G[2] <= square_two;
            1'b0 : VGA_R[2] <=square_two;
            default : VGA_R[2] <=square_two;
        endcase
        case(ALU_in[1])
            1'b1 : VGA_G[1] <= square_one;
            1'b0 : VGA_R[1] <=square_one;
             default : VGA_R[1] <=square_one;
        endcase
        case(ALU_in[0])
            1'b1 : VGA_G[0] <= square_zero;
            1'b0 : VGA_R[0] <=square_zero;
             default : VGA_R[0] <= square_zero;
        endcase
    end
endmodule
