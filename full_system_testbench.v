`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 11:31:55 AM
// Design Name: 
// Module Name: full_system_testbench
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


module full_system_testbench(
    );
    reg CLK100MHZ;
    reg [11:0]input_code;
    reg display_mode;
    reg counter_mode;
    wire c_out;
    wire [3:0] anode;
    wire [6:0] LED_out;
    wire VGA_HS_O;
    wire VGA_VS_O;
    wire [3:0]VGA_R;
    wire [3:0]VGA_G;
    //wire [11:0]hex_input;
    
    full_system T1( .CLK100MHZ(CLK100MHZ), .input_code(input_code), .display_mode(display_mode), .counter_mode(counter_mode), .c_out(c_out), .anode(anode), .LED_out(LED_out), .VGA_HS_O(VGA_HS_O), .VGA_VS_O(VGA_VS_O), .VGA_R(VGA_R), .VGA_G(VGA_G));
initial begin
    CLK100MHZ = 0;
    input_code = 0;
    display_mode = 0;
    counter_mode = 0;
end

always begin 
    #10 {input_code, display_mode, counter_mode, CLK100MHZ} = {input_code, display_mode, counter_mode, CLK100MHZ} + 1;
    if ({input_code, display_mode, counter_mode, CLK100MHZ} == 0)
        begin $finish;
    end
end

endmodule
