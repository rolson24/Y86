`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc 
// Engineer: Arthur Brown
// 
// Create Date: 07/27/2016 02:04:01 PM
// Design Name: Basys3 Keyboard Demo
// Module Name: top
// Project Name: Keyboard
// Target Devices: Basys3
// Tool Versions: 2016.X
// Description: 
//     Receives input from USB-HID in the form of a PS/2, displays keyboard key presses and releases over USB-UART.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//     Known issue, when multiple buttons are pressed and one is released, the scan code of the one still held down is ometimes re-sent.
//////////////////////////////////////////////////////////////////////////////////

// need to get this to work with ps2_keyboard_to_ascii
module keyboard_interface_top(         // need to integrate buffer perhaps
    input  clk,     // master clk
    input  PS2_data, // data from keyboard
    input  PS2_clk,  // keyboard clk
    input  KB_read_en,
    input  KB_clear,    // need to implement clear
    output KB_status,   // code read
    output [6:0] KB_data,
    output buf_full    
);
    
    wire        ascii_new = 0;
    wire [6:0]  ascii_data;
    
    keyboard_buf keyboard_buf(
        .clk(clk),
        .KB_read_en(KB_read_en),
        .KB_clear(KB_clear),
        .write_data(ascii_data),
        .write(ascii_new),
        .KB_status(KB_status),
        .read_data(KB_data),
        .buf_full(buf_full)
    );
    
    ps2_keyboard_to_ascii #(
        .clk_freq(50000000),
        .ps2_debounce_counter_size(8)
    )
    ps2_keyboard_to_ascii (
        .clk(clk),
        .ps2_clk(PS2_clk),
        .ps2_data(PS2_data),
        .ascii_new(ascii_new),
        .ascii_code(ascii_data)
    );
    
    
    
endmodule
