`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 07:50:56 PM
// Design Name: 
// Module Name: IO
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


module IO(
    input [31:0] addr,
    input [7:0] data_in,
    input RAM_use,
    input RAM_read,
    input RAM_write,
    input KB_status,
    input TTY_ready,
    input reset,
    input [6:0] KB_data,
    output KB_read_en,
    output KB_clear,
    output in_range,
    output reg [7:0] data_out,
    output reg [6:0] TTY_data,
    output TTY_en,
    output TTY_clear
    );
    
    wire KB_out_en;
    
    assign in_range = (addr[31:8] == 24'h00fffe);
    assign KB_out_en = (in_range & RAM_use & RAM_read & ~RAM_write);
    assign TTY_en = (in_range & RAM_use & RAM_write & ~RAM_read & (addr[3:0] == 4'hc));
    
    assign KB_read_en = (KB_out_en & (addr[3:0] == 4'h4));
    
    always @ (*) begin
        if (KB_out_en) begin
            case (addr[3:0])
                4'h0 : data_out = {7'b0000000, KB_status};
                4'h4 : data_out = {1'b0, KB_data};
                4'h8 : data_out = {7'b0000000, TTY_ready};
                default : data_out = 8'h0;
            endcase
        end else data_out = 'bz;
    end
    
    always @ (*)
        if (TTY_en == 1'b1) begin
            TTY_data = data_in[6:0];
        end else
            TTY_data = 7'h0;
    
    assign KB_clear = reset;
    assign TTY_clear = reset;
    
endmodule
