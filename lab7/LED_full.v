`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:33:14 04/14/2015 
// Design Name: 
// Module Name:    LED_full 
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
module LED_full(clk,remain,LED);
	input clk;
	input [3:0]remain;
	output reg LED;
	
	always @(posedge clk)
	begin
		if(remain==4'b0000)	LED <= 1'b1;
		else LED <= 1'b0;
	end

endmodule
