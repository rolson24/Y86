`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2022 06:53:17 PM
// Design Name: 
// Module Name: isplit
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


module isplit(
    input [7:0] B0,
    input [7:0] B1,
    input [7:0] B2,
    input [7:0] B3,
    input [7:0] B4,
    input [7:0] B5,
    output [3:0] icode,
    output [3:0] ifun,
    output [3:0] rA,
    output [3:0] rB,
    output [31:0] Dest,
    output [31:0] D_V
    );
    
    assign icode = B0[7:4];
    assign ifun = B0[3:0];
    assign rA = B1[7:4];
    assign rB = B1[3:0];
    assign Dest[7:0] = B1;
    assign Dest[15:8] = B2;
    assign Dest[23:16] = B3;
    assign Dest[31:24] = B4;
    assign D_V[7:0] = B2;
    assign D_V[15:8] = B3;
    assign D_V[23:16] = B4;
    assign D_V[31:24] = B5;
    
endmodule
