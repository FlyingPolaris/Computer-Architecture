`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/21 08:11:48
// Design Name: 
// Module Name: Top
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


module Top(
    input clk,
    input RESET
    );
    
    //IFID
    reg[31:0] ifid_pcplus4;
    reg[31:0] ifid_inst;
    
    //IDEX
    reg[9:0] idex_ctr;
        //RegDst [9]
        //AlUSrc [8]
        //MemToReg [7]
        //RegWrite [6]
        //MemRead [5]
        //MemWrite [4]
        //Branch [3]
        //ALUOp [2:0]
    reg idex_jump;
    reg[31:0] idex_pcplus4;
    reg[31:0] idex_imm;
    reg[31:0] idex_readdata1,idex_readdata2;
    reg[4:0] idex_readreg1,idex_readreg2,idex_writereg;
    
    //EXMEM
    reg[4:0] exmem_ctr;
        //MemToReg [4]
        //RegWrite [3]
        //MemRead [2]
        //MemWrite [1]
        //Branch [0]
    reg exmem_zero;
    reg[31:0] exmem_aluout, exmem_branch, exmem_writedata;
    reg[4:0] exmem_writereg;
    
    //MEMWB
    reg[1:0] memwb_ctr;
        //MemToReg [1]
        //RegWrite [0]
    reg[31:0] memwb_aluout, memwb_memout, memwb_writedata;
    reg[4:0] memwb_writereg;
    
    

    //PC
    reg[31:0] pc; 

    //STALL
    wire stall;
    assign stall = idex_ctr[5] && (ifid_inst[25:21] == idex_readreg2 | ifid_inst[20:16] == idex_readreg2);

    
    
    wire[31:0] inst, pcplus4, nextpc, jump_address, branch_address, jr_address;
    wire mainctr_branch, mainctr_jump, mainctr_jal, aluctr_jr, aluctr_shamt;
    wire[9:0] mainctr_res;
    wire[31:0] alu_src_A, alu_src_B, alures, mem_writedata;
    wire[31:0] imm_signext;
    wire[4:0] regdstout, reg_writereg;
    wire[3:0] aluctrout;
    assign pcplus4 = pc + 4;

    wire[31:0] branchout, jumpout;
    wire[31:0] reg_readdata1, reg_readdata2;
    wire[31:0] reg_writedata, mem_readdata, reg_final_writedata;
    wire zero;
    //IF
    InstMemory instmemory(
        .readaddress(pc),
        .instruction(inst)
    );
    
    //PC calculate
    assign jump_address = {ifid_pcplus4[31:28],ifid_inst[25:0],2'b00};
    assign branch_address = idex_pcplus4 + {idex_imm,2'b00};
    assign jr_address = idex_readdata1;

    assign mainctr_branch = idex_ctr[3] & zero;

   
    Mux branchmux(
        .input0(pcplus4),
        .input1(branch_address),
        .sel(mainctr_branch),
        .out(branchout)
    );
    
    Mux jumpmux(
        .input0(branchout),
        .input1(jump_address),
        .sel(mainctr_jump),
        .out(jumpout)
    );

    Mux jrmux(
        .input0(jumpout),
        .input1(jr_address),
        .sel(aluctr_jr),
        .out(nextpc)
    );
    
    always @ (posedge clk)
    begin
        if (!RESET && !stall) 
        begin
        ifid_pcplus4 <= pcplus4;
        ifid_inst <= inst;
        pc <= nextpc;
        if(mainctr_branch || mainctr_jump || aluctr_jr )
            begin
                ifid_pcplus4 <= 0;
                ifid_inst <= 0;
            end
        end
    end
    
    //ID

    Ctr mainctr(
        .OpCode(ifid_inst[31:26]),
        .RegDst(mainctr_res[9]),
        .AlUSrc(mainctr_res[8]),
        .MemToReg(mainctr_res[7]),
        .RegWrite(mainctr_res[6]),
        .MemRead(mainctr_res[5]),
        .MemWrite(mainctr_res[4]),
        .Branch(mainctr_res[3]),
        .ALUOp(mainctr_res[2:0]),
        .Jump(mainctr_jump),
        .Jal(mainctr_jal)
    );
    
    Mux_ regdstmux(
        .input0(ifid_inst[20:16]),
        .input1(ifid_inst[15:11]),
        .sel(mainctr_res[9]),
        .out(regdstout)
    );

    Mux_ jal_reg_mux(
        .input0(memwb_writereg),
        .input1(5'b11111),
        .sel(mainctr_jal),
        .out(reg_writereg)
    );

    Mux jal_data_mux(
        .input0(reg_writedata),
        .input1(ifid_pcplus4),
        .sel(mainctr_jal),
        .out(reg_final_writedata)
    );

    Registers registers(
        .RESET(RESET),
        .readreg1(ifid_inst[25:21]),
        .readreg2(ifid_inst[20:16]),
        .writereg(reg_writereg),
        .writedata(reg_final_writedata),
        .clk(clk),
        .regwrite(memwb_ctr[0]),
        .readdata1(reg_readdata1),
        .readdata2(reg_readdata2)
    );
    
    
    signext sign_ext(
        .inst(ifid_inst[15:0]),
        .data(imm_signext)
    );
   
    
    always @ (posedge clk)
    begin
        idex_jump <= mainctr_jump;
        idex_ctr <= mainctr_res;
        idex_pcplus4 <= ifid_pcplus4;
        idex_imm <= imm_signext;
        idex_readdata1 <= reg_readdata1;
        idex_readdata2 <= reg_readdata2;
        idex_readreg1 <= ifid_inst[25:21];
        idex_readreg2 <= ifid_inst[20:16];
        idex_writereg <= regdstout;
        if (mainctr_branch || mainctr_jump || aluctr_jr || stall) begin
            idex_jump <= 0;
            idex_ctr <= 0;
            idex_pcplus4 <= 0;
            idex_imm <= 0;
            idex_readdata1 <= 0;
            idex_readdata2 <= 0;
            idex_readreg1 <= 0;
            idex_readreg2 <= 0;
            idex_writereg <= 0;
        end
    end
    
    //Forwarding

    wire forwarding_ex_1;
    wire forwarding_ex_2;
    wire forwarding_mem_1;
    wire forwarding_mem_2;

    assign forwarding_ex_1 = exmem_ctr[3] & exmem_writereg != 0 & (exmem_writereg == idex_readreg1);
    assign forwarding_ex_2 = exmem_ctr[3] & exmem_writereg != 0 & (exmem_writereg == idex_readreg2);
    assign forwarding_mem_1 = memwb_ctr[0] & memwb_writereg != 0 & (memwb_writereg == idex_readreg1);
    assign forwarding_mem_2 = memwb_ctr[0]  & memwb_writereg != 0 & (memwb_writereg == idex_readreg2);

    //EX
    
    Aluctr aluctr(
        .ALUOp(idex_ctr[2:0]),
        .Funct(idex_imm[5:0]),
        .AluCtrOut(aluctrout),
        .Jr(aluctr_jr),
        .Shamt(aluctr_shamt)
    );
    
    
    
    assign alu_src_A = forwarding_ex_1 ? exmem_aluout : forwarding_mem_1 ? reg_writedata : aluctr_shamt ? {27'b00000000000000000000000000,idex_imm[10:6]} : idex_readdata1;
    assign alu_src_B =  idex_ctr[8] ? idex_imm : forwarding_ex_2 ? exmem_aluout : forwarding_mem_2 ? reg_writedata : idex_readdata2;
    assign mem_writedata = forwarding_ex_2 ? exmem_aluout : forwarding_mem_2 ? reg_writedata : idex_readdata2; 
    
    
    Alu alu(
        .aluctr(aluctrout),
        .input1(alu_src_A),
        .input2(alu_src_B),
        .zero(zero),
        .alures(alures)
    );

    
    always @ (posedge clk)
    begin
        exmem_zero <= zero;
        exmem_aluout <= alures;
        exmem_writereg <= idex_writereg;
        exmem_writedata <= mem_writedata;
        exmem_ctr <= idex_ctr[7:3];
        exmem_branch <= mainctr_branch;
    end
    
    //MEM
    
    dataMemory datamem(
        .clk(clk),
        .address(exmem_aluout),
        .writedata(exmem_writedata),
        .memwrite(exmem_ctr[1]),
        .memread(exmem_ctr[2]),
        .readdata(mem_readdata)
    );
    
    always @ (posedge clk)
    begin
        memwb_ctr <= exmem_ctr[4:3];
        memwb_aluout <= exmem_aluout;
        memwb_memout <= mem_readdata;
        memwb_writereg <= exmem_writereg;
    end
    
    Mux memtoregmux(
        .input0(memwb_aluout),
        .input1(memwb_memout),
        .sel(memwb_ctr[1]),
        .out(reg_writedata)
    );

    always @ (posedge clk)
    begin
        if(RESET)
        begin
            pc <= 0;
            ifid_inst <= 0;
            ifid_pcplus4 <= 0;
            idex_ctr <= 0;
            idex_imm <= 0;
            idex_jump <= 0;
            idex_pcplus4 <= 0;
            idex_readdata1 <= 0;
            idex_readdata2 <= 0;
            idex_readreg1 <= 0;
            idex_readreg2 <= 0;
            idex_writereg <= 0;
            exmem_aluout <= 0;
            exmem_branch <= 0;
            exmem_ctr <= 0;
            exmem_writedata <= 0;
            exmem_writereg <= 0;
            exmem_zero <= 0;
            memwb_aluout <= 0;
            memwb_ctr <= 0;
            memwb_memout <= 0;
            memwb_writereg <= 0;
        end


    end
endmodule
