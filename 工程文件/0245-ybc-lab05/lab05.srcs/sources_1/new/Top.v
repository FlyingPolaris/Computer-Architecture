`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 10:02:00
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
reg[31:0] pc;
wire[31:0] inst;
wire regdst;
wire jump;
wire branch;
wire memread;
wire memtoreg;
wire[2:0] aluop;
wire memwrite;
wire alusrc;
wire regwrite;
wire jal;
wire signext;
wire shamt;
wire jr;

InstMemory instmemory(
    .readaddress(pc),
    .instruction(inst)
);

Ctr mainctr(
    .OpCode(inst[31:26]),
    .RegDst(regdst),
    .Jump(jump),
    .Branch(branch),
    .MemRead(memread),
    .MemToReg(memtoreg),
    .ALUOp(aluop),
    .MemWrite(memwrite),
    .AlUSrc(alusrc),
    .RegWrite(regwrite),
    .Jal(jal),
    .signext(signext)
);

wire[31:0] readdata1;
wire[31:0] readdata2;
wire[31:0] writedata;
wire[4:0] writereg_tmp;
wire[4:0] writereg;

Mux_ regdst_mux(
    .input0(inst[20:16]),
    .input1(inst[15:11]),
    .sel(regdst),
    .out(writereg_tmp)
);

Mux_ jal_reg_mux(
    .input0(writereg_tmp),
    .input1(5'b11111),
    .sel(jal),
    .out(writereg)
);

Registers registers(
    .clk(clk),
    .RESET(RESET),
    .readdata1(readdata1),
    .readdata2(readdata2),
    .writedata(writedata),
    .readreg1(inst[25:21]),
    .readreg2(inst[20:16]),
    .writereg(writereg),
    .regwrite(regwrite & (~jr))
);

wire[3:0] aluctrout; 
Aluctr aluctr(
    .Shamt(shamt),
    .Jr(jr),
    .Funct(inst[5:0]),
    .ALUOp(aluop),
    .AluCtrOut(aluctrout)
);

wire[31:0] extopout;
signext extop(
    .signext(signext),
    .inst(inst[15:0]),
    .data(extopout)
);

wire[31:0] alusourceout;

Mux alusource_mux(
    .input1(extopout),
    .input0(readdata2),
    .sel(alusrc),
    .out(alusourceout)
);

wire [31:0] shamtout;
Mux shamt_mux(
    .input1({27'b00000000000000000000,inst[10:6]}),
    .input0(readdata1),
    .sel(shamt),
    .out(shamtout)
);
wire zero;
wire[31:0] alures;
Alu alu(
    .aluctr(aluctrout),
    .input1(shamtout),
    .input2(alusourceout),
    .zero(zero),
    .alures(alures)
);

wire[31:0] memreaddata;
dataMemory datamemory(
    .clk(clk),
    .address(alures),
    .writedata(readdata2),
    .memwrite(memwrite),
    .memread(memread),
    .readdata(memreaddata)
);

wire[31:0] writedata_tmp;
Mux memtoreg_mux(
    .input0(alures),
    .input1(memreaddata),
    .sel(memtoreg),
    .out(writedata_tmp)
);

Mux jal_mux(
    .input1(pc + 4),
    .input0(writedata_tmp),
    .sel(jal),
    .out(writedata)
);

wire[31:0] pc_plus_4;
wire[31:0] jump_address;
wire[31:0] branch_address;
wire[31:0] branch_out;
wire[31:0] jump_out;
wire[31:0] nextpc;

assign pc_plus_4 = pc + 4;
assign jump_address = {pc_plus_4[31:28],inst[25:0],2'b00};
assign branch_address = pc_plus_4 + {extopout,2'b00};

Mux branch_mux(
    .input0(pc_plus_4),
    .input1(branch_address),
    .sel(branch & zero),
    .out(branch_out)
);


Mux jump_mux(
    .input0(branch_out),
    .input1(jump_address),
    .sel(jump),
    .out(jump_out)
);

Mux jr_mux(
    .input0(jump_out),
    .input1(readdata1),
    .sel(jr),
    .out(nextpc)
);

always @ (posedge clk)
    begin
    if(RESET)
        pc <= 0;
    else
        pc <= nextpc;
    end
endmodule
