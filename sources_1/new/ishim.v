`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2022 04:40:01 PM
// Design Name: 
// Module Name: ishim
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


module ishim(
    input req,
    input [31:0] addr,
    input reset,
    input clk,
    output RAMuse,
    output RAMread,
    output done,
    input [7:0] data_from_RAM,
    output reg [31:0] RAMaddr,
    output reg [7:0] byte0,
    output reg [7:0] byte1,
    output reg [7:0] byte2,
    output reg [7:0] byte3,
    output reg [7:0] byte4,
    output reg [7:0] byte5
    );
    
    wire clear;
    reg in_use;
    reg [2:0] state;
    reg [7:0] data_reg_en;
    
    initial begin
        byte0 = 0;
        byte1 = 0;
        byte2 = 0;
        byte3 = 0;
        byte4 = 0;
        byte5 = 0;
        in_use = 0;
        state = 0;
        RAMaddr = 0;
    end
        
    assign clear = data_reg_en[6] | reset;
    assign done = ~in_use;
    assign RAMuse = in_use;
    assign RAMread = in_use;

    always @(posedge clk or posedge clear)
        if (clear)
            in_use <= 0;
        else if (clk == 1 & (~in_use))
            in_use <= req;
    
    always @ (posedge clk or posedge clear)
        if (clear)
            state <= 0;
        else if (clk == 1 & in_use)
            state <= state + 1;
    
    always @ (in_use or state)
        if (in_use)
            case (state)
                3'h0 : data_reg_en = 8'b00000001;
                3'h1 : data_reg_en = 8'b00000010;
                3'h2 : data_reg_en = 8'b00000100;
                3'h3 : data_reg_en = 8'b00001000;
                3'h4 : data_reg_en = 8'b00010000;
                3'h5 : data_reg_en = 8'b00100000;
                3'h6 : data_reg_en = 8'b01000000;
                3'h7 : data_reg_en = 8'b10000000;
            endcase
        else
            data_reg_en = 0;
    
    always @ (*) begin
        if (in_use)
            RAMaddr = addr + state;
        else
            RAMaddr = 'bz;
    end
    
    always @ (posedge clk or posedge reset)
        if (reset == 1) begin
            byte0 = 0;
            byte1 = 0;
            byte2 = 0;
            byte3 = 0;
            byte4 = 0;
            byte5 = 0;
        end
        else if (clk == 1) begin
            if (data_reg_en[0] == 1)
                byte0 = data_from_RAM;
            if (data_reg_en[1] == 1)
                byte1 = data_from_RAM;  
            if (data_reg_en[2] == 1)
                byte2 = data_from_RAM;
            if (data_reg_en[3] == 1)
                byte3 = data_from_RAM;
            if (data_reg_en[4] == 1)
                byte4 = data_from_RAM;
            if (data_reg_en[5] == 1)
                byte5 = data_from_RAM;
        end
    
endmodule
