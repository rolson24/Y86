`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Based on shell created by Sean Smith, Taylor Catchcart, and Vijay Kothari
// Modified by Raif Olson
// Create Date: 05/24/2022 10:58:52 AM
// Design Name: 
// Module Name: Y86_shell
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


module Y86_shell(
        input mclk,
        input reset,
        input KB_status,
        input [6:0] KB_data,
        input TTY_ready,
        output KB_read_en,
        output KB_clear,
        output [6:0] TTY_data,
        output TTY_en,
        output TTY_clear
    );
    // clk wires
    wire clk;
    
    // FSM wires
    wire [31:0] FSM_controls;
    wire [11:0] FSM_states;

    // Fetch
    wire IMemReq;
    wire [1:0] PCIncSel;
    wire valCsel;
    
    // Decode/Write-back
    wire srcAsel;
    wire srcBsel;
    wire dstEsel;
    wire [1:0] dstEreq;
    wire dstMreq;
    
    // Execute
    wire [1:0] aluAsel;
    wire aluBsel;
    wire aluOPsel;
    wire IdCC;
    
    // Memory
    wire MARsel;
    wire IdMAR;
    wire MDRsel;
    wire IdMDR;
    wire DMemReq;
    wire DMemWrite;
    
    // PC
    wire IdPC;
    wire [1:0] newPCsel;
    
    // PC register
    reg [31:0] PC = 0;
    
    // Main data registers
    reg [31:0] eax = 0;
    reg [31:0] ecx = 0;
    reg [31:0] edx = 0;
    reg [31:0] ebx = 0;
    reg [31:0] esp = 0;
    reg [31:0] ebp = 0;
    reg [31:0] esi = 0;
    reg [31:0] edi = 0;
    
    // Condition Code register
    reg [2:0] CC;
    
    // Memory Data register
    reg [31:0] MDR;
    
    // Memory Address register
    reg [31:0] MAR;
    
    // state machine register
    reg [5:0] currentState = 0;
    wire [5:0] nextState;
    
    // Connecting wires
    
    // PC
    wire [31:0] valP;
    reg [31:0] newPC;
    reg [31:0] PCInc;
    
    // CND
    wire cond_true;
    
    // instructions
    wire [7:0] B0;
    wire [7:0] B1;
    wire [7:0] B2;
    wire [7:0] B3;
    wire [7:0] B4;
    wire [7:0] B5;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    wire [31:0] Dest;
    wire [31:0] D_V;
    wire [31:0] valC;
    wire I_RAM_use;
    wire [31:0] I_RAM_addr;
    wire I_RAM_read;
    wire [7:0] I_data_in;
    wire I_Mem_ready;
    
    // reg writer
    wire [31:0] valM;
    wire [31:0] valE;
    wire [2:0] dstE;
    wire [2:0] dstM;
    reg reqE;
    wire reqM;
    wire [31:0] eax_in;
    wire [31:0] ecx_in;
    wire [31:0] edx_in;
    wire [31:0] ebx_in;
    wire [31:0] esp_in;
    wire [31:0] ebp_in;
    wire [31:0] esi_in;
    wire [31:0] edi_in;
    wire eax_en;
    wire ecx_en;
    wire edx_en;
    wire ebx_en;
    wire esp_en;
    wire ebp_en;
    wire esi_en;
    wire edi_en;
    
    // reg reader
    wire [31:0] eax_out;
    wire [31:0] ecx_out;
    wire [31:0] edx_out;
    wire [31:0] ebx_out;
    wire [31:0] esp_out;
    wire [31:0] ebp_out;
    wire [31:0] esi_out;
    wire [31:0] edi_out;
    wire [7:0] reset_regs;
    wire [31:0] valA;
    wire [31:0] valB;
    wire [2:0] srcA;
    wire [2:0] srcB;
    wire [3:0] srcBfull;
    //wire reset; maybe can just wire in
    
    // alu
    reg [31:0] aluA;
    wire [31:0] aluB;
    wire [3:0] aluOP;
    wire [2:0] ZSO;
    wire srcBf;
    // out is valE
    
    // dshim
    wire D_RAM_use;
    wire [31:0] D_RAM_addr;
    wire D_RAM_write;
    wire D_RAM_read;
    wire [7:0] D_data_to_RAM;
    wire [7:0] D_data_from_RAM;
    wire D_Mem_ready;
    
    // RAM wires
    wire RAMuse;
    wire RAMwrite;
    wire RAMread;
    reg [31:0] addr_bus;
    wire [9:0] I_addr;
    wire [7:0] I_data;
    wire I_use;
    wire D_use;
    wire [9:0] D_addr;
    wire [7:0] D_data;
    wire write_en;
    reg [7:0] data_out_bus;
    wire [7:0] IO_data_out;
    
    wire in_range;
    
    // Clock divider
    Clock_divider clk_div(
        .clock_in(mclk),
        .clock_out(clk)
    );
    /*buffg gbuff_for_mux(
        .out(clk), 
        .in(mclk)
    ); */

    // state machine logic
    FSM_control_ROM control_ROM(
        .clka(mclk),
        .addra(currentState),
        .douta(FSM_controls)
    );
    
    // Fetch
    assign IMemReq = FSM_controls[31];
    assign PCIncSel = FSM_controls[30:29];
    assign valCsel = FSM_controls[28];
    // Decode/Write-Back
    assign srcAsel = FSM_controls[27];
    assign srcBsel = FSM_controls[26];
    assign dstEsel = FSM_controls[25];
    assign dstEreq = FSM_controls[24:23];
    assign dstMreq = FSM_controls[22];
    // Execute
    assign aluAsel = FSM_controls[21:20];
    assign aluBsel = FSM_controls[19];
    assign aluOPsel = FSM_controls[18];
    assign IdCC = FSM_controls[17];
    // Memory
    assign MARsel = FSM_controls[16];
    assign IdMAR = FSM_controls[15];
    assign MDRsel = FSM_controls[14];
    assign IdMDR = FSM_controls[13];
    assign DMemReq = FSM_controls[12];
    assign DMemWrite = FSM_controls[11];
    // PC
    assign newPCsel = FSM_controls[10:9];
    assign IdPC = FSM_controls[8];
    
    microsequencer useq(
        .currentState(currentState),
        .select(FSM_states[11:10]),
        .icode(icode),
        .valN(FSM_states[9:4]),
        .DMemReady(D_Mem_ready),
        .IMemReady(I_Mem_ready),
        .nextState(nextState)
    );
    
    FSM_next_states FSM_next_states(
        .clka(mclk),
        .addra(currentState),
        .douta(FSM_states)
    );
    always @ (posedge clk) begin
        if (reset == 1)
            currentState = 0;
        else if (clk)
            currentState = nextState;
    end

    // PC register logic
    always @ (posedge clk or posedge reset) begin
        if (reset == 1) begin
            PC = 0;
        end else if (clk == 1 & IdPC == 1) begin
            PC = newPC;
        end 
    end
    
    always @ (PCIncSel) begin
        case (PCIncSel)
            2'h0 : PCInc = 'h1;
            2'h1 : PCInc = 'h2;
            2'h2 : PCInc = 'h5;
            2'h3 : PCInc = 'h6;
        endcase
    end
    
    assign valP = PCInc + PC;
    
    always @ (*) begin
        case (newPCsel)
            2'h0 : newPC = valP;
            2'h1 : newPC = valC;
            2'h2 : newPC = valM;
            2'h3 : newPC = cond_true ? valC : valP;
        endcase
    end
    
    // CND logic
    CND CND_i(
        .ZSO(CC),
        .ifun(ifun),
        .Cnd(cond_true)
    );
    
    // ishim logic
    
    ishim ishim_i(
        .req(IMemReq),
        .addr(PC),
        .reset(reset),
        .clk(clk),
        .data_from_RAM(I_data_in),
        .RAMuse(I_RAM_use),
        .RAMread(I_RAM_read),
        .done(I_Mem_ready),
        .RAMaddr(I_RAM_addr),
        .byte0(B0),
        .byte1(B1),
        .byte2(B2),
        .byte3(B3),
        .byte4(B4),
        .byte5(B5)
    );
    
    isplit isplit_i(
        .B0(B0),
        .B1(B1),
        .B2(B2),
        .B3(B3),
        .B4(B4),
        .B5(B5),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .Dest(Dest),
        .D_V(D_V)
    );
    
    assign valC = valCsel ? D_V : Dest;
    
    // reg writer logic
    assign dstE = dstEsel ? 4 : rB;
    always @ (dstEreq, cond_true) begin
        case (dstEreq)
            2'h0 : reqE = 0;
            2'h1 : reqE = 1;
            2'h2 : reqE = cond_true;
            default : reqE = 0;
        endcase
    end
    assign dstM = rA;
    assign reqM = dstMreq;
    
    regWriter regWriter_i(
        .dstE(dstE),
        .reqE(reqE),
        .dstM(dstM),
        .reqM(reqM),
        .valE(valE),
        .valM(valM),
        .D_0(eax_in),
        .D_1(ecx_in),
        .D_2(edx_in),
        .D_3(ebx_in),
        .D_4(esp_in),
        .D_5(ebp_in),
        .D_6(esi_in),
        .D_7(edi_in),
        .en_0(eax_en),
        .en_1(ecx_en),
        .en_2(edx_en),
        .en_3(ebx_en),
        .en_4(esp_en),
        .en_5(ebp_en),
        .en_6(esi_en),
        .en_7(edi_en)
    );
    
    // main register logic
    always @ (posedge clk or posedge reset_regs[0]) begin
        if (reset_regs[0])
            eax <= 0;
        else if (eax_en)
            eax <= eax_in;
    end
    always @ (posedge clk or posedge reset_regs[1]) begin
        if (reset_regs[1]) begin
            ecx <= 0;
        end else if (ecx_en) begin
            ecx <= ecx_in;
        end
    end
    always @ (posedge clk or posedge reset_regs[2]) begin
        if (reset_regs[2]) begin
            edx <= 0;
        end else if (clk & edx_en) begin
            edx <= edx_in;
        end
    end
    always @ (posedge clk or posedge reset_regs[3]) begin

        if (reset_regs[3]) begin
            ebx <= 0;
        end else if (clk & ebx_en) begin
            ebx <= ebx_in;
        end
    end
    always @ (posedge clk or posedge reset_regs[4]) begin

        if (reset_regs[4]) begin
            esp <= 0;
        end else if (clk & esp_en) begin
            esp <= esp_in;
        end
    end
    always @ (posedge clk or posedge reset_regs[5]) begin

        if (reset_regs[5]) begin
            ebp <= 0;
        end else if (clk & ebp_en) begin
            ebp <= ebp_in;
        end
    end
    always @ (posedge clk or posedge reset_regs[6]) begin

        if (reset_regs[6]) begin
            esi <= 0;
        end else if (clk & esi_en) begin
            esi <= esi_in;
        end
    end
    always @ (posedge clk or posedge reset_regs[7]) begin

        if (reset_regs[7]) begin
            edi <= 0;
        end else if (clk & edi_en) begin
            edi <= edi_in;
        end
    end
    
    // reg reader logic
    assign srcA = srcAsel ? 4 : rA;
    assign srcBfull = srcBsel ? 4 : rB;
    assign srcB = srcBfull[2:0];
    regReader regReader_i(
        .reset(reset),
        .srcA(srcA),
        .srcB(srcB),
        .Q_0(eax),
        .Q_1(ecx),
        .Q_2(edx),
        .Q_3(ebx),
        .Q_4(esp),
        .Q_5(ebp),
        .Q_6(esi),
        .Q_7(edi),
        .valA(valA),
        .valB(valB),
        .clr(reset_regs)
    );
    
    // alu logic
    always @ (*) begin
        case (aluAsel)
            2'h0 : aluA = valA;
            2'h1 : aluA = valC;
            2'h2 : aluA = 32'h4;
            2'h3 : aluA = 32'hfffffffc;
        endcase
    end
    
    assign srcBf = (srcBfull == 'hf);
    assign aluB = (aluBsel | srcBf) ? 0 : valB;
    assign aluOP = aluOPsel ? ifun : 0;
    
    alu alu_i(
        .aluA(aluA),
        .aluB(aluB),
        .aluOP(aluOP),
        .ZSO(ZSO),
        .valE(valE)
    );
    
    // CC reg logic
    always @ (posedge clk or posedge reset) begin
        if (reset == 1) begin
            CC = 0;
        end else if (clk == 1 & IdCC == 1) begin
            CC = ZSO;
        end
    end
    
    // dshim logic
    // MDR reg logic
    always @ (posedge clk or posedge reset) begin
        if (reset == 1) begin
            MDR = 0;
        end else if (clk == 1 & IdMDR == 1) begin
            MDR = MDRsel ? valP : valA;
        end
    end
    // MAR reg logic
    always @ (posedge clk or posedge reset) begin
        if (reset == 1) begin
            MAR = 0;
        end else if (clk == 1 & IdMAR == 1) begin
            MAR = MARsel ? valA : valE;
        end
    end
    
    dshim dshim_i(
        .addr(MAR),
        .DMemWrite(DMemWrite),
        .req(DMemReq),
        .reset(reset),
        .clk(clk),
        .data_in(MDR),
        .data_from_RAM(D_data_from_RAM),
        .RAMuse(D_RAM_use),
        .RAMaddr(D_RAM_addr),
        .data_to_RAM(D_data_to_RAM),
        .RAMwrite(D_RAM_write),
        .RAMread(D_RAM_read),
        .done(D_Mem_ready),
        .data_out(valM)
    );
    

    
    // RAM logic
    RAM_logic RAM_logic_i(
        .IRAMuse(I_RAM_use),
        .DataRAMuse(D_RAM_use),
        .DataRAMWrite(D_RAM_write),
        .DataRAMRead(D_RAM_read),
        .IRAMRead(I_RAM_read),
        .RAMuse(RAMuse),
        .RAMWrite(RAMwrite),
        .RAMRead(RAMread)
    );
    // kbyte buddy
    kbyte_buddy I_kb_buddy(
        .addr(addr_bus),
        .addrPrefix(0),
        .useBit(RAMuse),
        .ramAddr(I_addr),
        .sel(I_use)
    );
    
    I_ROM Instruction_ROM(
        .clka(mclk),
        .addra(I_addr),
        .douta(I_data)
    );
    
    // wire the addr's together
    always @ (I_RAM_addr) begin
        addr_bus = I_RAM_addr;
    end
    always @ (D_RAM_addr) begin
        addr_bus = D_RAM_addr;
    end
    
    // Data RAM
    Data_RAM RAM(
        .clka(mclk),
        .wea(write_en),
        .addra(D_addr),
        .dina(D_data_to_RAM),
        .douta(D_data)
    );
    
    // kbyte buddy
    kbyte_buddy D_kb_buddy(
        .addr(addr_bus),
        .addrPrefix(32'h0000f000),
        .useBit(RAMuse),
        .ramAddr(D_addr),
        .sel(D_use)
    );
    
    assign write_en = RAMwrite & D_use;
    
    always @ (*) begin
        if (RAMread & I_use)
            data_out_bus = I_data;
        else if (RAMread & D_use) 
            data_out_bus = D_data;
        else if (RAMread & in_range)
            data_out_bus = IO_data_out;
        else
            data_out_bus = 'bz;
    end
    
    // IO logic
    IO IO_i(
        .RAM_use(RAMuse),
        .addr(addr_bus),
        .data_in(D_data_to_RAM),
        .RAM_read(RAMread),
        .RAM_write(RAMwrite),
        .data_out(IO_data_out),
        .reset(reset),
        .KB_status(KB_status),
        .KB_data(KB_data),
        .KB_read_en(KB_read_en),
        .KB_clear(KB_clear),
        .TTY_ready(TTY_ready),
        .TTY_data(TTY_data),
        .TTY_en(TTY_en),
        .TTY_clear(TTY_clear),
        .in_range(in_range)
    );

    assign I_data_in = data_out_bus;
    assign D_data_from_RAM = data_out_bus;
    
    
endmodule
