`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 09:42:34 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] aluA,
    input [31:0] aluB,
    input [3:0] aluOP,
    output reg [2:0] ZSO,
    output reg [31:0] valE
    );
    
    wire neg_add_overflow;
    wire pos_add_overflow;
    wire neg_sub_overflow;
    wire pos_sub_overflow;
    
    wire [31:0] add_out;
    wire [31:0] sub_out;
    wire [31:0] and_out;
    wire [31:0] xor_out;
    
    initial begin
        ZSO = 0;
        // valE = 0;
    end
    
    assign add_out = aluB + aluA;
    assign sub_out = aluB - aluA;
    assign and_out = aluB & aluA;
    assign xor_out = aluB ^ aluA;
    
    assign pos_add_overflow = (aluA < 0) & (aluB < 0) & (and_out > 0);
    assign neg_add_overflow = (aluA > 0) & (aluB > 0) & (add_out < 0);
    assign neg_sub_overflow = (aluA < 0) & (aluB > 0) & (sub_out > 0);
    assign pos_sub_overflow = (aluA > 0) & (aluB < 0) & (sub_out < 0);
    
    always @ (*)
        case (aluOP)
            4'h0 : ZSO[0] = pos_add_overflow | neg_add_overflow;
            4'h1 : ZSO[0] = pos_sub_overflow | neg_sub_overflow;
            default : ZSO[0] = 1'b0;
        endcase
    
    always @ (*)
        if (valE == 32'h0) begin
            ZSO[2] <= 1;
        end else
            ZSO[2] <= 0;
            
    always @ (*)
        if (valE < 0) begin
            ZSO[1] <= 1;
        end else
            ZSO[1] <= 0;
    
    always @ (*)
        case (aluOP[1:0])
            2'h0 : valE <= add_out;
            2'h1 : valE <= sub_out;
            2'h2 : valE <= and_out;
            2'h3 : valE <= xor_out;
        endcase
    
endmodule
