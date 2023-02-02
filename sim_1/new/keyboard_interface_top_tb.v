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
    reg key_clk;
    reg KB_read_en; // request to send data out
    reg KB_clear;
    reg ps2_data;
    wire KB_status;
    wire [6:0] KB_data;
    wire buf_full;
    
    localparam period = 20;
    localparam key_period = 500000;   
     
    keyboard_interface_top UUT (
        .clk(clk),
        .PS2_clk(key_clk),
        .PS2_data(ps2_data),
        .KB_read_en(KB_read_en),
        .KB_clear(KB_clear),
        .KB_status(KB_status),
        .KB_data(KB_data),
        .buf_full(buf_full)
    );
    
    initial begin
        clk = 1'b0;
        key_clk = 1'b1;
        ps2_data = 1'b1;
        KB_read_en = 1'b0;
        KB_clear = 1'b0;
    end
    
    always #(period/2) clk = ~clk;
    //always #(key_period/2) key_clk = ~key_clk;
    
    initial
    begin
        #(2*key_period);
        key_clk = ~key_clk;
        ps2_data = 1'b0; // start bit
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;  // now set ascii h: 33, 0011 0011 least sig first
        #(key_period/2) key_clk = ~key_clk;   
        #(key_period/2) key_clk = ~key_clk;     
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1; // parity: 4 1's so even = 1
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1; // stop bit
        
        
    end
    
endmodule
