`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2022 06:13:06 PM
// Design Name: 
// Module Name: dshim
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


module dshim(
    input [31:0] addr,
    input DMemWrite,
    input req,
    input reset,
    input clk,
    input [31:0] data_in,
    input [7:0] data_from_RAM,
    output RAMuse,
    output reg [31:0] RAMaddr,
    output reg [7:0] data_to_RAM,
    output RAMwrite,
    output RAMread,
    output done,
    output reg [31:0] data_out
    );
    
    reg write ;
    reg in_use;
    reg [2:0] state;
    reg [3:0] data_reg_en;
    wire clear;
    
    reg [7:0] byte0;
    reg [7:0] byte1;
    reg [7:0] byte2;
    reg [7:0] byte3;
    
    initial begin
        byte0 = 0;
        byte1 = 0;
        byte2 = 0;
        byte3 = 0;
        state = 0;
        in_use = 0;
    end
    assign clear = (state == 3'h4) | reset;
    assign RAMwrite = write & in_use;
    assign RAMread = ~write & in_use;
    assign done = ~in_use;
    assign RAMuse = in_use;

    
    always @ (posedge clk or posedge reset) begin
        if (reset == 1) begin
            write = 0;
        end else if (clk == 1 & ~in_use) begin
            write = DMemWrite;
        end
    end
    
    always @ (posedge clk or posedge clear) begin
        if (clear == 1) begin
            in_use = 0;
            state = 0;
        end else if (clk) begin
            if (~in_use)
                in_use = req;
            else 
                state = state + 1;
        end
    end

    always @ (*) begin
        if (in_use)
            RAMaddr = addr + state;
        else
            RAMaddr = 'bz;
    end
    
    always @ (*)
        if (RAMread) begin
            case (state)
                3'h0 : data_reg_en = 'b0001;
                3'h1 : data_reg_en = 'b0010;
                3'h2 : data_reg_en = 'b0100;
                3'h3 : data_reg_en = 'b1000;
                default : data_reg_en = 0;
            endcase
        end else data_reg_en = 0;
        
    always @ (posedge clk or posedge reset)
        if (reset == 1) begin
            byte0 = 0;
            byte1 = 0;
            byte2 = 0;
            byte3 = 0;
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
        end
    
    always @ (byte0, byte1, byte2, byte3)
        data_out = {byte3, byte2, byte1, byte0};
    
    always @ (*)
        if (RAMwrite)
            case (state[1:0])
                2'h0 : data_to_RAM = data_in[7:0];
                2'h1 : data_to_RAM = data_in[15:8];
                2'h2 : data_to_RAM = data_in[23:16];
                2'h3 : data_to_RAM = data_in[31:24];
            endcase
        else
            data_to_RAM = 0;
    
endmodule
