`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2022 09:54:28 AM
// Design Name: 
// Module Name: IO_tb
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


module IO_tb;

    reg [31:0] addr;
    reg [7:0] data_in;
    reg RAMuse;
    reg RAMread;
    reg RAMwrite;
    reg reset;
    reg KB_status;
    reg [6:0] KB_data;
    reg TTY_status;
    wire [7:0] KB_data_out;
    wire [6:0] TTY_data_out;
    wire TTY_en;
    wire TTY_clear;
    wire KB_read_en;
    wire KB_clear;
    
    localparam period = 20;
    
    
    IO UUT (
        .addr(addr),
        .data_in(data_in),
        .RAM_use(RAMuse),
        .RAM_read(RAMread),
        .RAM_write(RAMwrite),
        .KB_status(KB_status),
        .TTY_ready(TTY_status),
        .reset(reset),
        .KB_data(KB_data),
        .KB_read_en(KB_read_en),
        .KB_clear(KB_clear),
        .data_out(KB_data_out),
        .TTY_data(TTY_data_out),
        .TTY_en(TTY_en),
        .TTY_clear(TTY_clear)
    );
    
    initial begin
        addr = 32'h00fffe00;
        RAMuse = 1;
        RAMread = 1;
        KB_status = 1;
        RAMwrite = 0;
        reset = 0;
        #period;
        
        addr = 32'h00fffe04;
        RAMuse = 1;
        RAMread = 1;
        KB_data = 7'h7;
        #period;
        
        addr = 32'h00fffe08;
        RAMuse = 0;
        RAMread = 1;
        TTY_status = 1;
        #period;
        
        RAMuse = 1;
        RAMread = 0;
        #period;
        
        RAMread = 1;
        #period;
        
        addr = 32'h00fffe0c;
        RAMread = 0;
        RAMwrite = 1;
        data_in = 8'h3;
        #period;
        
        reset = 1;
        #period;
    end;

endmodule
