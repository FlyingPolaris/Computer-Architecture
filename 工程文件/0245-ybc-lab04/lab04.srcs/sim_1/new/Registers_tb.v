`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 08:09:28
// Design Name: 
// Module Name: Registers_tb
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


module Registers_tb(

    );

reg [25:21] readreg1;
reg [20:16] readreg2;
reg [4:0] writereg;
reg [31:0] writedata;
reg clk;
reg regwrite;
wire [31:0] readdata1;
wire [31:0] readdata2;
    
Registers u0(
    .readreg1(readreg1),
    .readreg2(readreg2),
    .writereg(writereg),
    .writedata(writedata),
    .clk(clk),
    .regwrite(regwrite),
    .readdata1(readdata1),
    .readdata2(readdata2)
);

always #100 clk = 1 - clk;

initial begin
    clk = 0;
    readreg1 = 0;
    readreg2 = 0;
    writereg = 0;
    writedata = 0;
    regwrite = 0;
    
    #100;
    clk = 0;
    
    #185;
    regwrite = 1'b1;
    writereg = 5'b10101;
    writedata = 32'b11111111111111110000000000000000;
    
    #200;
    writereg = 5'b01010;
    writedata = 32'b00000000000000001111111111111111;
    
    #200;
    regwrite = 1'b0;
    writereg = 5'b00000;
    writedata = 32'b00000000000000000000000000000000;
    
    #50;
    readreg1 = 5'b10101;
    readreg2 = 5'b01010;

end
endmodule
