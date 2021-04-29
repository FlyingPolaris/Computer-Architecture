`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/24 19:11:17
// Design Name: 
// Module Name: Top_tb
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

module Top_tb(

    );
    
 reg clk;
 reg RESET;
 
 Top top(
    .clk(clk),
    .RESET(RESET)
 );
 
 
 initial begin
 #0;
 $readmemh("memfile.txt",top.datamem.memfile);
 $readmemb("instfile.txt",top.instmemory.instfile);
 RESET = 1;
 clk = 1;
 #80;
 RESET = 0;
 #6000;
 end
 
 always #20 clk = ~clk;
 

endmodule
