`timescale 1ns / 1ps

module decoder(
    input [3:0] a,
    input [3:0] b,
    input [3:0] op_code,
    input [3:0] count_in,
    input counter_mode, // Make this either a button or switch, whatever fits
    output wire [11:0] instr_code,
    output reg [11:0] BCD,
    output c_out,
    output reg [3:0]four_bit_out // For VGA display
    );
    reg mode;
    reg [2:0] Op;
    wire [3:0] temp_out; // This is the 4 bit output needed for the VGA display
    wire [3:0] temp_tens;
    wire [3:0] temp_ones;
    
    // Used to test counter 7 seg display functionality
    // When in hex mode, 7 seg will display count output
    //wire [3:0] count;
    //assign count_sim = 4'b1111;
    wire [3:0] count_tens;
    wire [3:0] count_ones;
    
    reg c_in = 1'b0;
    assign instr_code [7:4] = a;
    assign instr_code [3:0] = b;
    assign instr_code [11:8] = op_code;

    
    always @(*)
    begin
    case (counter_mode)
        1'b1: begin
         // Counter feed goes in here
            Op <= 3'b000; // This doesn't matter, only using hex
            mode <= 1'b0; // Doesn't matter, only using hex
            BCD[11:8] <= 4'b0000; // Positive sign
            BCD[7:4] <= count_tens;
            BCD[3:0] <= count_ones;
            four_bit_out <= count_in; //input from counter
        end
        1'b0 : begin
            case(op_code)
                4'b0000: begin //negate a
                         Op <= 3'b000;
                         mode <= 1'b1;
                         BCD[11:8] <= 4'b0001;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end                   
                4'b0001: begin //negate b
                         Op <= 3'b001;
                         mode <= 1'b1;
                         BCD[11:8] <= 4'b0001;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b0010: begin //not A
                         Op <= 3'b110;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b0011: begin //not B
                         Op <= 3'b111;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end  
                4'b0100: begin // A+B
                         Op <= 3'b010;
                         mode <= 1'b1;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b0101: begin // A-B
                         Op <= 3'b011;
                         mode <= 1'b1;
                         if (a<b) BCD[11:8] <= 4'b0001;
                         else BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b0110: begin // A+1
                         Op <= 3'b110;
                         mode <= 1'b1;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b0111: begin //A-1
                         Op <= 3'b111;
                         mode <= 1'b1;
                         if (a < 1) BCD[11:8] <= 4'b0001;
                         else BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b1000: begin //A*B
                         Op <= 3'b100;
                         mode <= 1'b1;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b1001: begin //B-A
                         Op <= 3'b101;
                         mode <= 1'b1;
                         if (b<a) BCD[11:8] <= 4'b0001;
                         else BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end         
                4'b1010: begin // A and B
                         Op <= 3'b000;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end         
                4'b1011: begin // A or B
                         Op <= 3'b001;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b1100: begin //A NAND B
                         Op <= 3'b010;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b1101: begin //A NOR B
                         Op <= 3'b011;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                4'b1110: begin //A XOR B
                         Op <= 3'b100;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                 4'b1111: begin //A XNOR B
                         Op <= 3'b101;
                         mode <= 1'b0;
                         BCD[11:8] <= 4'b0000;
                         BCD[7:4] <= temp_tens;
                         BCD[3:0] <= temp_ones;
                         four_bit_out <= temp_out;
                         end
                 // Defaults for latches
                 default : begin
                    BCD[11:8] <= 4'b0000;
                    BCD[7:4] <= temp_tens;
                    BCD[3:0] <= temp_ones;
                    four_bit_out <= temp_out;
                    Op <= 3'b000;
                    mode <= 1'b1;
                 end
                endcase                                   
            end
        endcase
    end
    
    
    full_alu main_alu (.a(a), .b(b),.Op(Op), .c_out(c_out), .c_in(c_in), .out(temp_out),.mode(mode));
    BCD convert (.binary(temp_out),.tens(temp_tens),.ones(temp_ones));
    BCD count_convert(.binary(count_in), .tens(count_tens), .ones(count_ones));
    // Counter module fed in here
    
    
endmodule