`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 09:16:03 PM
// Design Name: 
// Module Name: regWriter
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


module reg_file(
    input clk,
    input reset,
    input [2:0] srcA,
    output [31:0] valA,
    input [2:0] srcB,
    output [31:0] valB,
    
    input [2:0] dstE,
    input reqE,
    input [31:0] valE,
    input [2:0] dstM,
    input reqM,
    input [31:0] valM
    );
    
    reg [31:0] reg_array [7:0];
    integer i;
    
    initial begin
      for(i=0;i<8;i=i+1)
        reg_array[i] <= 16'd0;
    end
    
    always @ (posedge clk) begin
      if(reqE) begin
        reg_array[dstE] <= valE;
      end
      if(reqM) begin
        reg_array[dstM] <= valM;
      end
    end
    
    assign valA = reg_array[srcA];
    assign valB = reg_array[srcB];
 
endmodule
