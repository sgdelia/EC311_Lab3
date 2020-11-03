`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 10:05:35 PM
// Design Name: 
// Module Name: display_outline_test
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


module display_outline_test(

    );
    /*
    module display_outline(
input CLK100MHZ, // This is the clock on my Basys 3. You'll have to change it for the school FPGA
input mode, // hex or alu output
input [11:0]instructions, // instructions fed to alu, in binary, simulated by switches for now
input [11:0]alu_result, // what the alu spit out, BCD number, simulated by board switches for now
output reg [3:0]anode, // which anode we're on
output reg [6:0]LED_out // segments of the anode
*/

reg CLK100MHZ;
reg mode;
reg [11:0]instructions;
reg [11:0]alu_result;
wire [3:0]anode;
wire [6:0]LED_out;
endmodule
