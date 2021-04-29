`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 09:46:47
// Design Name: 
// Module Name: Aluctr
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


module Aluctr(
    input [2:0] ALUOp,
    input [5:0] Funct,
    output reg [3:0] AluCtrOut,
    output reg Shamt,
    output reg Jr
    );
always @ (ALUOp or Funct)
begin
    Shamt = 0;
    Jr = 0;
    casex({ALUOp,Funct})
    
        9'b000XXXXXX: AluCtrOut = 4'b0010;//lw,sw
        9'b001XXXXXX: AluCtrOut = 4'b0110;//beq
        9'b010XXXXXX: AluCtrOut = 4'b0010;//addi
        9'b011XXXXXX: AluCtrOut = 4'b0000;//andi
        9'b100XXXXXX: AluCtrOut = 4'b0001;//ori
        9'b101000000://sll 
            begin
                AluCtrOut = 4'b0011;
                Shamt = 1; 
            end
        9'b101000010://srl
            begin
                AluCtrOut = 4'b0100;
                Shamt = 1;
            end
        9'b101001000://jr
            begin
                AluCtrOut = 4'b0101;
                Jr = 1;  
            end          
        9'b101100000: AluCtrOut = 4'b0010;//add
        9'b101100010: AluCtrOut = 4'b0110;//sub
        9'b101100100: AluCtrOut = 4'b0000;//and
        9'b101100101: AluCtrOut = 4'b0001;//or
        9'b101101010: AluCtrOut = 4'b0111;//slt
        9'b110XXXXXX: AluCtrOut = 4'b0101;//j,jal
        default:      AluCtrOut = 4'b0000;
        
    endcase
end
endmodule
