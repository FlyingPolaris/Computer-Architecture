`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 09:56:14
// Design Name: 
// Module Name: Aluctr_tb
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


module Aluctr_tb(

    );
    reg[5:0] Funct;
    reg[1:0] ALUOp;
    wire[3:0] AluCtrOut; 
    Aluctr u0(
        .Funct(Funct),
        .ALUOp(ALUOp),
        .AluCtrOut(AluCtrOut)
    );
    
    initial begin
   
    {ALUOp,Funct} = 8'b00000000;
    
    #60 {Funct,ALUOp} = 8'b00000000;    
    #60 {Funct,ALUOp} = 8'b00000000;
    #60 {Funct,ALUOp} = 8'b00000001;
    #60 {Funct,ALUOp} = 8'b00000010;
    #60 {Funct,ALUOp} = 8'b00001010;
    #60 {Funct,ALUOp} = 8'b00010010;
    #60 {Funct,ALUOp} = 8'b00010110;
    #60 {Funct,ALUOp} = 8'b00101010;
    
    
    end
 
    
endmodule
