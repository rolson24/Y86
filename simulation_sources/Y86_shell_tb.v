`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2022 07:50:16 PM
// Design Name: 
// Module Name: Y86_shell_tb
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


module Y86_shell_tb;
    reg clk;
    reg reset;
    wire KB_status;
    wire [6:0] KB_data;
    reg TTY_ready = 1;
    wire KB_read_en;
    wire KB_clear;
    wire [6:0] TTY_data;
    wire TTY_en;
    wire TTY_clear;
    reg ps2_data = 1;
    reg key_clk = 1;
    
    localparam period = 5;
    localparam key_period = 50000;   

    
    // update the port map
    Y86_shell DUT(
        .SYS_CLK(clk),
        .ps2_in(ps2_data),
        .ps2_clk(key_clk),
        .reset(reset),
        //.KB_status(KB_status),
        //.KB_data(KB_data),
        .TTY_ready(TTY_ready),
        //.KB_read_en(KB_read_en),
        //.KB_clear(KB_clear),
        .TTY_data(TTY_data),
        .TTY_en(TTY_en),
        .TTY_clear(TTY_clear)
    );
    
    // need to look at instruction rom
    initial begin
        clk = 1'b0;
        TTY_ready = 1'b1;
        reset = 1'b1;
    end
    
    always #(period/2) clk = ~clk;
    //always #(key_period/2) key_clk = ~key_clk;
    
    initial
    begin
        #(period/2);
        #(3*period);
        reset = 1'b0;
        
//        #(2*key_period);
//        ps2_data = 1'b0; // start bit
//        #(key_period);
//        #(key_period/2) key_clk = ~key_clk; //1
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b0;  // now send keycode self-test: 0xaa, 1010 1010 least sig first
//        #(key_period/2) key_clk = ~key_clk;   //2
//        #(key_period/2) key_clk = ~key_clk;     
//        ps2_data = 1'b1;
//        #(key_period/2) key_clk = ~key_clk; //3
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b0;
//        #(key_period/2) key_clk = ~key_clk; //4 
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b1;
//        #(key_period/2) key_clk = ~key_clk; //5 
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b0;
//        #(key_period/2) key_clk = ~key_clk; // 6
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b1; 
//        #(key_period/2) key_clk = ~key_clk; // 7
//        #(key_period/2) key_clk = ~key_clk; 
//        ps2_data = 1'b0;
//        #(key_period/2) key_clk = ~key_clk; //8
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b1;
//        #(key_period/2) key_clk = ~key_clk; //9
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b1; // parity: 4 1's so even = 0
//        #(key_period/2) key_clk = ~key_clk; //10
//        #(key_period/2) key_clk = ~key_clk;
//        ps2_data = 1'b1; // stop bit
//        #(key_period/2) key_clk = ~key_clk; //10
//        #(key_period/2) key_clk = ~key_clk;
        
        #(2*key_period);
        
        ps2_data = 1'b0; // start bit
        #(key_period);
        #(key_period/2) key_clk = ~key_clk; //1
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;  // now send keycode a: 0x1c, 0001 1100 least sig first
        #(key_period/2) key_clk = ~key_clk;   //2
        #(key_period/2) key_clk = ~key_clk;     
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk; //3
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk; //4 
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk; //5 
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk; // 6
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0; 
        #(key_period/2) key_clk = ~key_clk; // 7
        #(key_period/2) key_clk = ~key_clk; 
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk; //8
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk; //9
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0; // parity: 3 1's so even = 0
        #(key_period/2) key_clk = ~key_clk; //10
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1; // stop bit
        #(key_period/2) key_clk = ~key_clk; //10
        #(key_period/2) key_clk = ~key_clk;
        
        #(15*key_period);

        ps2_data = 1'b0; // start bit
        #(key_period/2);
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;  // now send keycode shift: 0x12, 0001 0010 least sig first
        #(key_period/2) key_clk = ~key_clk;   
        #(key_period/2) key_clk = ~key_clk;     
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1; // parity: 4 1's so even = 1
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1; // stop bit
        #(key_period/2) key_clk = ~key_clk; //10
        #(key_period/2) key_clk = ~key_clk;
        
        #(2*key_period);
        ps2_data = 1'b0; // start bit
        #(key_period/2);
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;  // now send keycode h: 0x33, 0011 0011 least sig first
        #(key_period/2) key_clk = ~key_clk;   
        #(key_period/2) key_clk = ~key_clk;     
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b0;
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1; // parity: 4 1's so even = 1
        #(key_period/2) key_clk = ~key_clk;
        #(key_period/2) key_clk = ~key_clk;
        ps2_data = 1'b1; // stop bit
        #(key_period/2) key_clk = ~key_clk; //10
        #(key_period/2) key_clk = ~key_clk;
        
    end
    
    initial begin
        $monitor("Output display: %c", TTY_data);
        
    end

endmodule
