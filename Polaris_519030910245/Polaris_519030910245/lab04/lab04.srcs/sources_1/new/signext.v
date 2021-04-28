`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 09:27:47
// Design Name: 
// Module Name: signext
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


module signext(
    input signext,
    input [15:0] inst,
    output [31:0] data
    );
    
    assign data = signext ? {(inst[15] == 1) ? (inst|32'hffff0000) : (inst|32'h00000000)} : (inst|32'h00000000);   
endmodule
