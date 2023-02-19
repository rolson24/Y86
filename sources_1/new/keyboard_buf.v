`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2022 09:42:06 AM
// Design Name: 
// Module Name: keyboard_buf
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


module keyboard_buf
    #(parameter baud_rate=115200)
   (input clk,
    input KB_read_en,
    input KB_clear,
    input [6:0] write_data,     // was rx_data
    input write,
    output KB_status,
    output [6:0] read_data,     // was KB_data
    output buf_full
    );
    
    wire [5:0] write_addr, read_addr; /*extra bit to tell difference between full and empty (5 bits for address, most significant 1 for full or empty)*/
    wire fifo_write_en, fifo_read_en;
    wire fifo_empty, fifo_full;
    
    assign buf_full = fifo_full;
    assign KB_status = ~fifo_empty;
    
    write_pointer write_pointer(
        .clk(clk),
        .reset(KB_clear),
        .fifo_full(fifo_full),
        .write(write),
        .write_addr(write_addr),
        .fifo_write_en(fifo_write_en));
    read_pointer read_pointer(
        .clk(clk),
        .reset(KB_clear),
        .read(KB_read_en),
        .fifo_empty(fifo_empty),
        .read_addr(read_addr),
        .fifo_read_en(fifo_read_en));
    memory_array memory(
        .clk(clk),
        .data_in(write_data),
        .fifo_write_en(fifo_write_en),
        .write_addr(write_addr),
        .read_addr(read_addr),
        .data_out(read_data));
    status_signal signals(
        .clk(clk),
        .reset(KB_clear),
        .write(write),
        .read(KB_read_en),
        .fifo_write_en(fifo_write_en),
        .fifo_read_en(fifo_read_en),
        .write_addr(write_addr),
        .read_addr(read_addr),
        .fifo_full(fifo_full),
        .fifo_empty(fifo_empty));
    
endmodule

module memory_array(
    input [6:0] data_in, /*for ascii*/
    input clk,
    input fifo_write_en,
    input [5:0] write_addr,
    input [5:0] read_addr,
    output[6:0] data_out);
    
    reg [6:0] array [31:0];
    
    always @ (posedge clk) begin
        if (fifo_write_en)
            array[write_addr[4:0]] <= data_in;
    end 
    assign data_out = array[read_addr];
    
endmodule

module read_pointer(
    input clk,
    input read,
    input fifo_empty,
    input reset,
    output reg [5:0] read_addr = 6'b000000,
    output fifo_read_en);
    
    assign fifo_read_en = (~fifo_empty) & read;
    always @(posedge clk or posedge reset) begin
        if(reset)
            read_addr <= 6'b000000;
        else if(fifo_read_en)
            read_addr <= read_addr + 6'b000001;
        else
            read_addr <= read_addr;
    end
endmodule

module status_signal(
    input write,
    input read,
    input fifo_write_en,
    input fifo_read_en,
    input clk,
    input reset,
    input [5:0] write_addr,
    input [5:0] read_addr,
    output reg fifo_full = 0,
    output reg fifo_empty = 1);

    wire full_bit;
    wire empty_bit;
    wire pointer_equal;
    assign full_bit = write_addr[5] & read_addr[5];
    assign empty_bit = ~write_addr[5] & ~read_addr[5];
    assign pointer_equal = ((write_addr[4:0] - (read_addr[4:0]))) ? 0:1;
    
    always @(*) begin
        fifo_full = full_bit & pointer_equal;
        fifo_empty = empty_bit & pointer_equal;
    end
endmodule

module write_pointer(
    input clk,
    input reset,
    input fifo_full,
    input write,
    output reg [5:0] write_addr = 6'b000000,
    output fifo_write_en);
    
    assign fifo_write_en = (~fifo_full) & write;
    
    always @ (posedge clk or posedge reset) begin
        if (reset)
            write_addr <= 6'b000000;
        else if (fifo_write_en)
            write_addr <= write_addr + 6'b000001;
        else
            write_addr <= write_addr;
    end
endmodule
