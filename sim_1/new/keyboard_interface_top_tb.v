`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2023 09:33:17 PM
// Design Name: 
// Module Name: keyboard_interface_top_tb
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


module keyboard_interface_top_tb;
    
    reg clk;
    reg KB_read_en; // request to send data out
    reg KB_clear;
    reg [7:0] rx_data;
    reg rx_done;
    wire KB_status;
    wire [6:0] KB_data;
    wire buf_full;
    
    localparam period = 50;
    
    keyboard_interface_top UUT (
        .clk(clk),
        .KB_read_en(KB_read_en),
        .KB_clear(KB_clear),
        .rx_data(rx_data),
        .rx_done(rx_done),
        .KB_status(KB_status),
        .KB_data(KB_data),
        .buf_full(buf_full)
    );
    
   initial begin
        clk = 1'b1;
        KB_read_en = 1'b0;
        KB_clear = 1'b1;
        #period KB_clear = 1'b0;
        rx_data = 8'b00000000;
        rx_done = 1'b0;
        forever begin
            #(period/2) clk = ~clk;
        end
    end

endmodule
