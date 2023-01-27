`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2022 08:57:22 PM
// Design Name: 
// Module Name: RAM_logic
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


module RAM_logic(
    input IRAMuse,
    input DataRAMuse,
    input DataRAMWrite,
    input DataRAMRead,
    input IRAMRead,
    output RAMuse,
    output RAMWrite,
    output RAMRead
    );
    
    assign RAMuse = IRAMuse | DataRAMuse;
    assign RAMWrite = DataRAMWrite;
    assign RAMRead = DataRAMRead | IRAMRead;
    
endmodule
