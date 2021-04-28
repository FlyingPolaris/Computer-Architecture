`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 11:43:39
// Design Name: 
// Module Name: Registers
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


module Registers(
    input [25:21] readreg1,
    input [20:16] readreg2,
    input [4:0] writereg,
    input [31:0] writedata,
    input clk,
    input RESET,
    input regwrite,
    output reg [31:0] readdata1,
    output reg [31:0] readdata2
    );
    
    reg [31:0] regfile[31:0];
    
    always @ (readreg1 or readreg2 or writereg)
        begin
            if(readreg1)
                readdata1 = regfile[readreg1];
            else 
                readdata1 = 0;
            if(readreg2)
                readdata2 = regfile[readreg2];
            else
                readdata2 = 0;
        end
        
     always @ (negedge clk)
        begin
            if(regwrite && writereg != 0)
                regfile[writereg] = writedata;

            if(readreg1)
                readdata1 = regfile[readreg1];
            else 
                readdata1 = 0;
            if(readreg2)
                readdata2 = regfile[readreg2];
            else
                readdata2 = 0;

            if(RESET)
             begin
            for(i=0;i<32;i=i+1)
                regfile[i]=0;
             end
        end
     
     reg[5:0] i;
     always @(RESET)
        begin
            for(i=0;i<32;i=i+1)
                regfile[i]=0;
        end
endmodule
