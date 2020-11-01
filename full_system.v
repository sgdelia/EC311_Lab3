`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2020 10:07:48 PM
// Design Name: 
// Module Name: full_system
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

module full_system(
    input CLK100MHZ, 
    // For seven segment / counter
    input [11:0] input_code, 
    input display_mode,
    input counter_mode,
    // input counter_button,
    // For seven segment display
    output wire c_out,
    output [3:0] anode,
    output [6:0] LED_out,
    // For VGA display
    //output four_bit_out,
    output wire VGA_HS_O, 
    output wire VGA_VS_O,
    output [3:0]VGA_R,
    output [3:0]VGA_G
       );
    wire [11:0]BCD;
    wire [11:0]code;
    wire[3:0]four_bit_out;
    
    decoder dc1 (.counter_mode(counter_mode),.op_code(input_code[11:8]), .a(input_code[7:4]), .b(input_code[3:0]),.BCD(BCD), .instr_code(code), .c_out(c_out), .four_bit_out(four_bit_out));
    display_outline disp1 (.CLK100MHZ(CLK100MHZ), .mode(display_mode), .instructions(code), .alu_result(BCD), .anode(anode), .LED_out(LED_out));
    output_squares OS(.ALU_in(four_bit_out), .CLK100MHZ(CLK100MHZ), .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O), .VGA_R(VGA_R[3:0]), .VGA_G(VGA_G[3:0])); 
endmodule
