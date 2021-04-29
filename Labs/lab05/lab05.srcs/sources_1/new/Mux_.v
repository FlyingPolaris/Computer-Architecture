`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/07 10:51:27
// Design Name: 
// Module Name: Mux_
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


module Mux_(
    input [4:0] input1,
    input [4:0] input0,
    input sel,
    output [4:0] out
    );
    
    assign out = sel ? input1 : input0;

endmodule
