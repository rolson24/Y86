`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/02/2022 09:26:47 PM
// Design Name: 
// Module Name: dshim_tb
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
///////////////w///////////////////////////////////////////////////////////////////


module dshim_tb;

    reg [31:0] addr = 0;
    reg DMemWrite = 0;
    reg req = 0;
    reg reset = 0;
    reg clk = 1;
    reg [31:0] data_in = 0;
    reg [7:0] data_from_RAM = 0;
    wire RAMuse;
    wire [31:0] RAMaddr;
    wire [7:0] data_to_RAM;
    wire RAMwrite;
    wire RAMread ;
    wire done;
    wire [31:0] data_out;
    
    localparam period = 20;
    
    dshim dshim_test(
        .addr(addr),
        .DMemWrite(DMemWrite),
        .req(req),
        .reset(reset),
        .clk(clk),
        .data_in(data_in),
        .data_from_RAM(data_from_RAM),
        .RAMuse(RAMuse),
        .RAMaddr(RAMaddr),
        .data_to_RAM(data_to_RAM),
        .RAMwrite(RAMwrite),
        .RAMread(RAMread),
        .done(done),
        .data_out(data_out)
    );
    
    always #(period/2) clk = ~clk;

    
    initial begin
    
        #(2*period);
        data_from_RAM = 8'h68;
        req = 1;
        #period;
        req = 0;
        #period;
        #period;
        #period;
        data_from_RAM = 0;

        #period
        #period;
        #period
        #period;
        #period;
        
        #period; // check output here
        
        #period;
        #period;
        
        DMemWrite = 1;
        req = 1;
        #period;
        #period;
        #period;
        #period;
        #period;
        #period;
        #period;
        #period;
        
        #period;
        #period;
        
    end

endmodule
