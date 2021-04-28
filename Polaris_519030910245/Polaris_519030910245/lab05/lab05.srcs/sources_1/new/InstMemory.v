`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 09:52:33
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input [31:0] readaddress,
    output [31:0] instruction
    );

reg [31:0] instruction;
reg [31:0] instfile[31:0];

always @ (readaddress)
    begin
        instruction = instfile[readaddress/4];
    end

endmodule
