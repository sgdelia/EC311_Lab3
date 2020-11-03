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
    output wire VGA_HS_O, 
    output wire VGA_VS_O,
    output [3:0]VGA_R,
    output [3:0]VGA_G
    //output reg [11:0]hex_input
       );
    wire [11:0]BCD; // four_bit_out in BCD
    reg [11:0]hex_input; //instructions fed to ALU or count output in BCD
    wire [11:0]code; // instructions fed to ALU
    wire[3:0]four_bit_out;
    // assign BCD_sim = BCD;
    
    // Problem: In count mode, count does not display on seven segment. Can confirm that correct BCD code is being fed to display
    // Can confirm count mode is activated (Displays correctly on VGA)
    // Instructions are displayed in BCD, not ALU result. Need to make counter output
    // Fed to instructions, not ALU_result
    
    
    
    decoder dc1 (.counter_mode(counter_mode),.op_code(input_code[11:8]), .a(input_code[7:4]), .b(input_code[3:0]), .BCD(BCD), .instr_code(code), .c_out(c_out), .four_bit_out(four_bit_out));
    display_outline ALU_disp (.CLK100MHZ(CLK100MHZ), .mode(display_mode), .instructions(hex_input), .alu_result(BCD), .anode(anode), .LED_out(LED_out));
    output_squares OS(.ALU_in(four_bit_out), .CLK100MHZ(CLK100MHZ), .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O), .VGA_R(VGA_R[3:0]), .VGA_G(VGA_G[3:0])); 

always @ (*) begin
    case (counter_mode)
        1'b1: begin
            hex_input <= BCD;
        end
        1'b0: begin
            hex_input <= code;
        end // End 1'b0
    endcase // end counter mode case
end // End display loop

endmodule
