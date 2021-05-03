`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 11:13:06
// Design Name: 
// Module Name: Alu_tb
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


module Alu_tb(

    );
    reg [31:0] input1;
    reg [31:0] input2;
    reg [3:0] aluctr;
    wire [31:0] alures;
    wire zero;
    
    Alu u0(
        .input1(input1),
        .input2(input2),
        .aluctr(aluctr),
        .alures(alures),
        .zero(zero)
    );
    
    initial begin
    
    input1 = 0;
    input2 = 0;
    aluctr = 4'b0000;
    
    #100
    input1 = 15;
    input2 = 10;
    
    #100
    aluctr = 4'b0001;
    
    #100
    aluctr = 4'b0010;
    
    #100
    aluctr = 4'b0110;
    
    #100
    input1 = 10;
    input2 = 15;
    
    #100
    aluctr = 4'b0111;
    input1 = 15;
    input2 = 10;
    
    #100
    input1 = 10;
    input2 = 15;
    
    #100
    input1 = 1;
    input2 = 1;
    aluctr = 4'b1100;
    
    #100
    input1 = 16;
    end
    
endmodule
