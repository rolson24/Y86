`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/26/2023 12:26:33 PM
// Design Name: 
// Module Name: keyboard_buf_tb
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


module keyboard_buf_tb;

    reg clk;
    reg KB_read_en; // request to send data out
    reg KB_clear;
    reg [7:0] rx_data;
    reg rx_done;
    reg KB_status;
    reg [6:0] KB_data;
    reg buf_full;
    
    localparam period = 50;
    
    keyboard_buf UUT (
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
        clk = 1'b0;
        KB_read_en = 1'b0;
        #period KB_clear = 1'b1;
        rx_data = 8'b00000000;
        rx_done = 1'b0;
        forever begin
            #(period/2) clk = ~clk;
        end
    end
    
    //68 65 6C 6C 6F 20 77 6F 72 6C 64
    
    initial begin
        #(5*period);
        // h
        rx_data = 8'h68; // need to figure this out. RX data is data shifted in from spi reciever and is marked ready with rx_done is high
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // e
        #period;
        rx_data = 8'h65;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // l
        #period;
        rx_data = 8'h6c;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // l
        #period;
        rx_data = 8'h6c;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // o
        #period;
        rx_data = 8'h6f;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // " "
        #period;
        rx_data = 8'h20;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // w
        #period;
        rx_data = 8'h77;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // o
        #period;
        rx_data = 8'h6f;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // r
        #period;
        rx_data = 8'h72;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // l
        #period;
        rx_data = 8'h6c;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // d
        #period;
        rx_data = 8'h64;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        // send out h
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // e
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // l
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // l
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // o
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // " "
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // w
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // o
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // r
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // l
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        // d
        #(3*period);
        KB_read_en = 1'b1;
        #period;
        KB_read_en = 1'b0;
        
        #(3*period); // KB_status should be 0
        // put in e
        rx_data = 8'h65;
        #(2*period);
        rx_done = 1'b1;
        #period;
        rx_done = 1'b0;
        
        #period; // KB_status should be 1
        
        KB_clear = 1'b1;
        #period;
        KB_clear = 1'b0;
        
        #period; // KB_status should be 0
        
    end
    
    
        
endmodule