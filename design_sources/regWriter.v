`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 09:16:03 PM
// Design Name: 
// Module Name: regWriter
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


module regWriter(
    input [2:0] dstE,
    input reqE,
    input [31:0] valE,
    input [2:0] dstM,
    input reqM,
    input [31:0] valM,
    output en_0,
    output [31:0] D_0,
    output en_1,
    output [31:0] D_1,
    output en_2,
    output [31:0] D_2,
    output en_3,
    output [31:0] D_3,
    output en_4,
    output [31:0] D_4,
    output en_5,
    output [31:0] D_5,
    output en_6,
    output [31:0] D_6,
    output en_7,
    output [31:0] D_7
    );
    
    reg [7:0] A_enables = 0;
    reg [7:0] B_enables = 0;
    /*
    initial begin
        D_0 <= 0;
        D_1 <= 0;
        D_2 <= 0;
        D_3 <= 0;
        D_4 <= 0;
        D_5 <= 0;
    end
    */
    
    always @ (*)
        if (reqE)
            case (dstE)
                3'b000 : A_enables = 8'b00000001;
                3'b001 : A_enables = 8'b00000010;
                3'b010 : A_enables = 8'b00000100;
                3'b011 : A_enables = 8'b00001000;
                3'b100 : A_enables = 8'b00010000;
                3'b101 : A_enables = 8'b00100000;
                3'b110 : A_enables = 8'b01000000;
                3'b111 : A_enables = 8'b10000000;
            endcase
        else
            A_enables = 'h0;
        
    always @ (*)
        if (reqM)
            case (dstM)
                3'b000 : B_enables = 8'b00000001;
                3'b001 : B_enables = 8'b00000010;
                3'b010 : B_enables = 8'b00000100;
                3'b011 : B_enables = 8'b00001000;
                3'b100 : B_enables = 8'b00010000;
                3'b101 : B_enables = 8'b00100000;
                3'b110 : B_enables = 8'b01000000;
                3'b111 : B_enables = 8'b10000000;
            endcase
        else
            B_enables = 'h0;
    
    assign en_0 = A_enables[0] | B_enables[0];
    assign en_1 = A_enables[1] | B_enables[1];
    assign en_2 = A_enables[2] | B_enables[2];
    assign en_3 = A_enables[3] | B_enables[3];
    assign en_4 = A_enables[4] | B_enables[4];
    assign en_5 = A_enables[5] | B_enables[5];
    assign en_6 = A_enables[6] | B_enables[6];
    assign en_7 = A_enables[7] | B_enables[7];
    
    assign D_0 = A_enables[0] ? valE : valM;
    assign D_1 = A_enables[1] ? valE : valM;
    assign D_2 = A_enables[2] ? valE : valM;
    assign D_3 = A_enables[3] ? valE : valM;
    assign D_4 = A_enables[4] ? valE : valM;
    assign D_5 = A_enables[5] ? valE : valM;
    assign D_6 = A_enables[6] ? valE : valM;
    assign D_7 = A_enables[7] ? valE : valM;
    
endmodule
