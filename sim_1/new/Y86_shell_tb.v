`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2022 07:50:16 PM
// Design Name: 
// Module Name: Y86_shell_tb
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


module Y86_shell_tb;
    reg clk;
    reg reset;
    wire KB_status;
    wire [6:0] KB_data;
    reg TTY_ready = 1;
    wire KB_read_en;
    wire KB_clear;
    wire [6:0] TTY_data;
    wire TTY_en;
    wire TTY_clear;
    
    localparam period = 50;
    
    // update the port map
    Y86_shell DUT(
        .mclk(clk),
        .reset(reset),
        .KB_status(KB_status),
        .KB_data(KB_data),
        .TTY_ready(TTY_ready),
        .KB_read_en(KB_read_en),
        .KB_clear(KB_clear),
        .TTY_data(TTY_data),
        .TTY_en(TTY_en),
        .TTY_clear(TTY_clear)
    );
    
    // need to look at instruction rom
    initial begin
        clk = 1'b0;
        TTY_ready = 1'b1;
        #period reset = 1'b1;
        reset = 1'b0;
        forever begin
            #(period/2) clk = ~clk;
        end
    end
    
    initial begin
        $monitor("Output display: %c", TTY_data);
        
    end

endmodule
