`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 08:40:19
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] OpCode,
    output reg RegDst,
    output reg AlUSrc,
    output reg MemToReg,
    output reg RegWrite,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg [2:0] ALUOp,
    output reg Jump,
    output reg Jal,
    output reg signext
    );
    
    always @(OpCode)
    begin
        case(OpCode)
        6'b000000://R
        begin
            RegDst = 1;
            AlUSrc = 0;
            MemToReg = 0;
            RegWrite = 1;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 3'b101;
            Jump = 0;
            Jal = 0;
            signext = 0;
        end
        
        6'b000100://beq
        begin
            RegDst = 0;
            AlUSrc = 0;
            MemToReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 1;
            ALUOp = 3'b001;
            Jump = 0;
            Jal = 0;
            signext = 1;
        end
        
        6'b100011://lw
        begin
            RegDst = 0;
            AlUSrc = 1;
            MemToReg = 1;
            RegWrite = 1;
            MemRead = 1;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 3'b000;
            Jump = 0;
            Jal = 0;
            signext = 1;
        end
        
         6'b101011://sw
        begin
            RegDst = 0;
            AlUSrc = 1;
            MemToReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 1;
            Branch = 0;
            ALUOp = 3'b000;
            Jump = 0;
            Jal = 0;
            signext = 1;
        end
        
        6'b000010://j
        begin
            RegDst = 0;
            AlUSrc = 0;
            MemToReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 3'b110;
            Jump = 1;
            Jal = 0;
            signext = 0;
        end

         6'b000011://jal
            begin
                RegDst = 0;
                AlUSrc = 0;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b110;
                Jump = 1;
                Jal = 1;
                signext = 0;
            end        
        
         6'b001000:      // addi
            begin
                RegDst = 0;
                AlUSrc = 1;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b010;
                Jump = 0;
                Jal = 0;
                signext = 1;
            end

         6'b001100:      // andi
            begin
                RegDst = 0;
                AlUSrc = 1;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b011;
                Jump = 0;
                Jal = 0;
                signext = 0;
            end

         6'b001101:      // ori
            begin
                RegDst = 0;
                AlUSrc = 1;
                MemToReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 3'b100;
                Jump = 0;
                Jal = 0;
                signext = 0;
            end
        default:
        begin
            RegDst = 0;
            AlUSrc = 0;
            MemToReg = 0;
            RegWrite = 0;
            MemRead = 0;
            MemWrite = 0;
            Branch = 0;
            ALUOp = 2'b00;
            Jump = 0;
            Jal = 0;
            signext = 0;
        end
        endcase
    end
endmodule
