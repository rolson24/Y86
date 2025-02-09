`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2022 09:23:20 AM
// Design Name: 
// Module Name: mircrosequencer_tb
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


module mircrosequencer_tb;
    
    reg [5:0] currentState;
    reg [1:0] select;
    reg [3:0] icode;
    reg [5:0] valN;
    reg DMemReady;
    reg IMemReady;
    wire [5:0] nextState;
    
    
    localparam period = 20;
    
    microsequencer UUT (
        .currentState(currentState),
        .select(select),
        .icode(icode),
        .valN(valN),
        .DMemReady(DMemReady),
        .IMemReady(IMemReady),
        .nextState(nextState)
    );
    
    initial begin
        currentState = 0;
        select = 0;
        icode = 4'h7;
        valN = 6'h2;
        DMemReady = 0;
        IMemReady = 0;
        #period;

        select = 2'h1;
        currentState = nextState;
        #period;
        
        currentState = nextState;
        valN = 6'h3;
        select = 2'h2;
        DMemReady = 1;
        #period;
        
        currentState = nextState;
        select = 2'h3;
        IMemReady = 1;
        #period;
    end
    
endmodule
