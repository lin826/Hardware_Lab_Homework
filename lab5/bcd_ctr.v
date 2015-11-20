`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:24 03/10/2015 
// Design Name: 
// Module Name:    bcd_ctr 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module bcd_ctr (clk, En, Clear_n, BCD);
input clk, En, Clear_n;
output [3:0] BCD;
reg [3:0] BCD;
  // add your design here
  
  always@(posedge clk, negedge Clear_n)
  begin
		if(Clear_n==0)        BCD <= 4'b0000;
		else if(En && BCD==9) BCD <= 4'b0000;
		else if(En)           BCD <= BCD+1'b1;
	end
endmodule
