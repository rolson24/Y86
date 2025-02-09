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


module spi_rx
    #(parameter baud_rate=115200)
   (input clk,
    input rs_rx,
    output rx_done,
    output [7:0] rx_data
    );
    
    reg sync_a = 0;
    reg sync_b = 0;
    reg [7:0] shift_reg = "00000000";
    reg [7:0] buffer [31:0];
    
    always @ (clk) begin
        sync_a <= rs_rx;
        sync_b <= sync_a;
    end
    
    /* shift reg and data reg*/
    
    /* controller */
    
        
endmodule