`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2023 02:49:14 PM
// Design Name: 
// Module Name: keyboard_top
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


module keyboard_top(
    input  clk,     // board clk
    input  PS2Data, // keyboard data
    input  PS2Clk,  // keyboard clk
    input  KB_read_en,
    input  KB_clear,
    output KB_status,
    output [6:0] KB_data,
    output buf_full
    );
    
    wire keycode_in [15:0];
    wire keycode_buf [6:0];
    
    
    
endmodule
