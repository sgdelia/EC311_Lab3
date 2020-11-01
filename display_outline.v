`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2020 10:42:28 PM
// Design Name: 
// Module Name: display_outline
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


module display_outline(
input CLK100MHZ, // This is the clock on my Basys 3. You'll have to change it for the school FPGA
input mode, // hex or alu output
input [11:0]instructions, // instructions fed to alu, in binary, simulated by switches for now
input [11:0]alu_result, // what the alu spit out, BCD number, simulated by board switches for now
output reg [3:0]anode, // which anode we're on
output reg [6:0]LED_out // segments of the anode
    );
reg [19:0] refresh_counter; // Generates 380 Hz refresh rate. Only using 2 bits
wire [1:0] anode_activator; // Cycles through anodes

//BCD Digits for Instructions
wire [3:0]ones; // B
wire [3:0]tens; // A
wire [3:0]hundreds; // Op Code
//BCD digits for alu_result
wire[3:0]aluOnes;
wire[3:0]aluTens;
wire[3:0]aluSign;

initial begin
refresh_counter = 0; // set counter to zero so she doesn't get angery.
end

// Convert instructions to BCD
assign ones = instructions[3:0]; // B
assign tens = instructions[7:4]; // A
assign hundreds = instructions[11:8]; // Op

// Convert alu_result to BCD
assign aluOnes = alu_result[3:0];
assign aluTens = alu_result[7:4];
assign aluSign = alu_result[11:8];

// Display Timing
always @(posedge CLK100MHZ)
begin
    refresh_counter <= refresh_counter +1; // add to the counter so the refresh rate is right
end

assign anode_activator = refresh_counter[19:18]; // cycle through signals for 4 anodes using refresh speeds

always @ (*)begin
    case(mode)
    1'b0 : begin // If Hex Mode
        case(anode_activator) // tells the anodes to light up alternately
          2'b00 : begin // far left
                anode = 4'b0111; // activate 1, deactivate 2,3,4
                LED_out = 7'b0000001; // Only 3 digits displayed     
                end
           2'b01 : begin // middle left
                anode = 4'b1011;
                case(hundreds)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase  
           end
           2'b10 : begin // middle right
                anode = 4'b1101;
                case(tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase   
           end
           2'b11 : begin // far right
                anode = 4'b1110;
                case(ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase    
           end   
        endcase
    end
   
    1'b1 : begin // If ALU Case
           case(anode_activator)
                2'b00 : begin // far left
                anode = 4'b0111; // activate 1, deactivate 2,3,4
                LED_out = 7'b0000001; // Only 3 digits displayed     
                end
           2'b01 : begin // middle left
                anode = 4'b1011;
                case(aluSign)
                    4'b0000 : LED_out = 7'b0000001; // If positive, show a zero
                    4'b0001 : LED_out = 7'b1111110; // If negative, show a negative sign
                    default : LED_out <= 7'b0000001; // Positive default
             endcase  
           end
           2'b10 : begin // middle right
                anode = 4'b1101;
                case(aluTens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase     
           end
           2'b11 : begin // far right
                anode = 4'b1110;
                case(aluOnes)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
                endcase
                end
           endcase 
       end
   endcase
end   
endmodule

// Inner Modules
/*case(anode_activator) // tells the anodes to light up alternately
            2'b00 : begin // far left
                anode = 4'b0111; // activate 1, deactivate 2,3,4
                LED_out = 7'b0000001; // Only 3 digits displayed     
                end
           2'b01 : begin // middle left
                anode = 4'b1011;
                case(aluSign)
                    4'b0000 : LED_out = 7'b0000001; // If positive, show a zero
                    4'b0001 : LED_out = 7'b1111110; // If negative, show a negative sign
                    default : LED_out <= 7'b0000001; // Positive default
             endcase  
           end
           2'b10 : begin // middle right
                anode = 4'b1101;
                case(aluTens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase     
           end
           2'b11 : begin // far right
                anode = 4'b1110;
                case(aluOnes)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
                endcase
                end
  */
  
  /*
  case(anode_activator) // tells the anodes to light up alternately
            2'b00 : begin // far left
                anode = 4'b0111; // activate 1, deactivate 2,3,4
                LED_out = 7'b0000001; // Only 3 digits displayed     
                end
           2'b01 : begin // middle left
                anode = 4'b1011;
                case(hundreds)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase  
           end
           2'b10 : begin // middle right
                anode = 4'b1101;
                case(tens)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000; 
                    default : LED_out <= 7'b0000001;
             endcase   
           end
           2'b11 : begin // far right
                anode = 4'b1110;
                case(ones)
                    4'b0000 : LED_out = 7'b0000001;
                    4'b0001 : LED_out = 7'b1001111;
                    4'b0010 : LED_out <= 7'b0010010;
                    4'b0011 : LED_out <= 7'b0000110;
                    4'b0100 : LED_out <= 7'b1001100;          
                    4'b0101 : LED_out <= 7'b0100100;
                    4'b0110 : LED_out <= 7'b0100000;
                    4'b0111 : LED_out <= 7'b0001111;
                    4'b1000 : LED_out <= 7'b0000000;
                    4'b1001 : LED_out <= 7'b0000100;
                    4'b1010 : LED_out <= 7'b0001000;
                    4'b1011 : LED_out <= 7'b1100000;
                    4'b1100 : LED_out <= 7'b0110001;
                    4'b1101 : LED_out <= 7'b1000010;
                    4'b1110 : LED_out <= 7'b0110000;
                    4'b1111 : LED_out <= 7'b0111000;
                    default : LED_out <= 7'b0000001; 
             endcase    
           end   
  endcase
  */
         

// Every four bit input
/*
4'b0000
4'b0001 
4'b0010 
4'b0011 
4'b0100           
4'b0101 
4'b0110 
4'b0111 
4'b1000
4'b1001 
4'b1010 
4'b1011 
4'b1100 
4'b1101 
4'b1110 
4'b1111 
*/


// Hex Representations of every 4 bit digit
/*
hex_digits[0] = 7'b0000001;
assign hex_digits[1] = 7'b1001111;
assign hex_digits[2] = 7'b0010010;
assign hex_digits[3] = 7'b0000110;
assign hex_digits[4] = 7'b1001100;
assign hex_digits[5] = 7'b0100100;
assign hex_digits[6] = 7'b0100000;
assign hex_digits[7] = 7'b0001111;
assign hex_digits[8] = 7'b0000000;
assign hex_digits[9] = 7'b0000100;
assign hex_digits[10] = 7'b0001000;
assign hex_digits[11] = 7'b1100000;
assign hex_digits[12] = 7'b0110001;
assign hex_digits[13] = 7'b1000010;
assign hex_digits[14] = 7'b0110000;
assign hex_digits[15] = 7'b0111000;
*/

