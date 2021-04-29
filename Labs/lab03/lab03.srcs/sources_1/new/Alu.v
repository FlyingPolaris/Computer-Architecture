`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 10:58:34
// Design Name: 
// Module Name: Alu
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


module Alu(
    input [3:0] aluctr,
    input [31:0] input1,
    input [31:0] input2,
    output reg zero,
    output reg [31:0] alures
    );
    
    always @(input1 or input2 or aluctr)
    begin
        case(aluctr)
        4'b0010://add
            begin
            alures = input1 + input2;
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end
        4'b0110://sub
            begin
            alures = input1 - input2;
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end
        4'b0000://and
            begin
            alures = input1 & input2;
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end
        4'b0001://or
            begin
            alures = input1 | input2;
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end
        4'b1100://nor
            begin
            alures = ~(input1 | input2);
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end
        4'b0111://slt
            begin
            if(input1 < input2)
                begin
                alures = 1;
                zero = 0;
                end
            else
                begin
                alures = 0;
                zero = 1;
                end
            end   
        4'b0011://ls
            begin
            alures = input2 << input1;
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end     
        4'b0100://rs
            begin
            alures = input2 >> input1;
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end  
        4'b0101://nothing
            begin
            alures = input1;
            if(alures == 0)
                zero = 1;
            else 
                zero = 0;
            end  
        endcase
    end
endmodule
