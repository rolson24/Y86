`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 04:55:01 PM
// Design Name: 
// Module Name: CND
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


module CND(
    input [2:0] ZSO,
    input [3:0] ifun,
    output reg Cnd
    );
    
    always @ (ifun, ZSO) begin
        case (ifun) 
            4'h0 : Cnd = 4'h1;
            4'h1 : Cnd = ZSO[2] | (ZSO[0] ^ ZSO [1]);
            4'h2 : Cnd = ZSO[1] | ZSO[0];
            4'h3 : Cnd = ZSO[2];
            4'h4 : Cnd = ~ZSO[2];
            4'h5 : Cnd = ~(ZSO[1] ^ ZSO[0]);
            4'h6 : Cnd = ~ZSO[2] & ~(ZSO[1] ^ ZSO[0]);
            default : Cnd = 0;
        endcase
    end
    
endmodule
