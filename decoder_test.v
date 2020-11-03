`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2020 09:38:36 PM
// Design Name: 
// Module Name: decoder_test
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


module decoder_test(
    );
    /*
    input [3:0] a,
    input [3:0] b,
    input [3:0] op_code,
    input counter_mode, // Make this either a button or switch, whatever fits
    output wire [11:0] instr_code,
    output reg [11:0] BCD,
    output c_out,
    output reg [3:0]four_bit_out // For VGA display
    );
    */
    // As of 11/2/2020, can confirm decoder is working
    reg [3:0]a;
    reg [3:0]b;
    reg [3:0]op_code;
    reg counter_mode;
    wire [11:0]instr_code;
    wire [11:0] BCD;
    wire c_out;
    wire [3:0]four_bit_out;
    
    decoder decode_test (.a(a), .b(b), .op_code(op_code), .counter_mode(counter_mode), .instr_code(instr_code), .BCD(BCD), .c_out(c_out), .four_bit_out(four_bit_out)); 
    
    initial begin
    a = 0;
    b = 0;
    op_code = 0;
    counter_mode = 0;
    end
    
    always begin
        #10 {a,b, op_code, counter_mode} = {a,b,op_code, counter_mode} + 1;
        if ({a,b,op_code, counter_mode} == 0) begin
            $finish;
        end
    end
endmodule
