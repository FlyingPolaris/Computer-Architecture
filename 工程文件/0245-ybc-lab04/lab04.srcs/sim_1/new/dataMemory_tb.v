`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 08:52:49
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb(
    
    );

    reg clk;
    reg [31:0] address;
    reg [31:0] writedata;
    reg memwrite;
    reg memread;
    wire [31:0] readdata;

dataMemory u0(
    .clk(clk),
    .address(address),
    .writedata(writedata),
    .memwrite(memwrite),
    .memread(memread),
    .readdata(readdata)
);

always #100 clk = 1 - clk;

initial begin

clk = 0;
address = 0;
writedata = 0;
memwrite = 0;
memread = 0;

#185;
memwrite = 1'b1;
address = 32'b00000000000000000000000000000111;
writedata = 32'b11100000000000000000000000000000;

#100;
memwrite = 1'b1;
writedata = 32'hffffffff;
address = 32'b00000000000000000000000000000110;

#185;
memread = 1'b1;
memwrite = 1'b0;
address = 32'b00000000000000000000000000000111;

#80;
memwrite = 1;
address = 8;
writedata = 32'haaaaaaaa;

#80;
memwrite = 0;
memread = 1;
address = 32'b00000000000000000000000000000110;


end
endmodule
