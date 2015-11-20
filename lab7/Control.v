`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:39 04/14/2015 
// Design Name: 
// Module Name:    Control 
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
module Control(clk, pressed, moving, remain);
	input clk;
	input [1:0]pressed,moving;
	output reg [3:0]remain = 4'b1100;
	
	reg in,out;
	
	always @(posedge clk)
	begin
		remain <= remain - in + out;
	end
	
	always @(posedge clk)
	begin
		// entry
		if(pressed[1] && remain>0 && !moving[1]) in <= 1'b1;
		else in <= 1'b0;
	end
	always @(posedge clk)
	begin
		// exit
		if(pressed[0] && remain<12 && !moving[0]) out <= 1'b1;
		else out <= 1'b0;
	end


endmodule
