`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 05:10:49 PM
// Design Name: 
// Module Name: kbyte_buddy
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


module kbyte_buddy(
    input [31:0] addr,
    input [31:0] addrPrefix,
    input useBit,
    output [9:0] ramAddr,
    output sel
    );
    
    wire equal = 0;
    
    assign sel = ((addr & 32'hfffffc00) == addrPrefix) & useBit;
    
    assign ramAddr = addr[9:0];
    
endmodule
