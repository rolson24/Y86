//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2022 01:54:43 PM
// Design Name: 
// Module Name: microsequencer
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


module microsequencer(
    input [5:0] currentState,
    input [1:0] select,
    input [3:0] icode,
    input [5:0] valN,
    input DMemReady,
    input IMemReady,
    output reg [5:0] nextState
    );
    
    wire [5:0] DMemNextState;
    wire [5:0] IMemNextState;
        
    assign DMemNextState = DMemReady ? valN : currentState;
    
    assign IMemNextState = IMemReady ? (6'b110000 | icode) : currentState;
    
    always @ (*) begin
        case (select)
            2'h0 : nextState = currentState;
            2'h1 : nextState = valN;
            2'h2 : nextState = DMemNextState;
            2'h3 : nextState = IMemNextState;
        endcase
    end
    // assign nextState = select[1] ? (select[0] ? IMemNextState : DMemNextState) : (select[0] ? valN : currentState);
        
    
endmodule
