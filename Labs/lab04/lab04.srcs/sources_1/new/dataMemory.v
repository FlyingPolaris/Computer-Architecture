`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 08:37:30
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input clk,
    input [31:0] address,
    input [31:0] writedata,
    input memwrite,
    input memread,
    output reg [31:0] readdata
    );
    
    reg[31:0] memfile[0:10000];
    
    always @ (memread or address)
        begin
             if(memread)
                readdata = memfile[address]; 
             else
                readdata = 0;
        end
        
    always @ (negedge clk)
        begin
            if(memwrite)
            begin
                memfile[address] <= writedata;
            end
        end
endmodule
