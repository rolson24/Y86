`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 09:01:45 PM
// Design Name: 
// Module Name: regReader
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


module regReader(
    input reset,
    input [2:0] srcA,
    output reg [31:0] valA,
    input [2:0] srcB,
    output reg [31:0] valB,
    output [7:0] clr,
    input [31:0] Q_0,
    input [31:0] Q_1,
    input [31:0] Q_2,
    input [31:0] Q_3,
    input [31:0] Q_4,
    input [31:0] Q_5,
    input [31:0] Q_6,
    input [31:0] Q_7
    );
    
    assign clr = reset ? 8'b11111111 : 8'b00000000; //  change for different reset vals
    
    
    always @ (*)
        case (srcA)
            3'b000 : valA = Q_0;
            3'b001 : valA = Q_1;
            3'b010 : valA = Q_2;
            3'b011 : valA = Q_3;
            3'b100 : valA = Q_4;
            3'b101 : valA = Q_5;
            3'b110 : valA = Q_6;
            3'b111 : valA = Q_7;
        endcase
    
    always @ (*)
         case (srcB)
            3'b000 : valB = Q_0;
            3'b001 : valB = Q_1;
            3'b010 : valB = Q_2;
            3'b011 : valB = Q_3;
            3'b100 : valB = Q_4;
            3'b101 : valB = Q_5;
            3'b110 : valB = Q_6;
            3'b111 : valB = Q_7;
        endcase
    
    
endmodule
