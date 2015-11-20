`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:25 04/14/2015 
// Design Name: 
// Module Name:    seg_remain 
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
module seg_remain(clk, remain, seg_1, seg_2);
	input clk;
	input [3:0]remain;
	output reg [0:14]seg_1,seg_2;
	
	parameter BCD0 = 15'b0000_0011_1100111,
		BCD1 = 15'b1001_1111_1111111,
		BCD2 = 15'b0010_0100_1111111,
		BCD3 = 15'b0000_1100_1111111,
		BCD4 = 15'b1001_1000_1111111,
		BCD5 = 15'b0100_1000_1111111,
		BCD6 = 15'b0100_0000_1111111,
		BCD7 = 15'b0001_1111_1111111,
		BCD8 = 15'b0000_0000_1111111,
		BCD9 = 15'b0000_1000_1111111,
		DARK = 15'b1111_1111_1111111;
	
	always @(posedge clk)
	begin
		case (remain[3:0])	// abcd_efg1g2_hjklmnp
			4'h0: seg_1 = BCD0;
			4'h1: seg_1 = BCD1;
			4'h2: seg_1 = BCD2;
			4'h3: seg_1 = BCD3;
			4'h4: seg_1 = BCD4;
			4'h5: seg_1 = BCD5;
			4'h6: seg_1 = BCD6;
			4'h7: seg_1 = BCD7;
			4'h8: seg_1 = BCD8;
			4'h9: seg_1 = BCD9;			
			4'hA: seg_1 = BCD0;
			4'hB: seg_1 = BCD1;
			4'hC: seg_1 = BCD2;
			default: seg_1 = 15'b1111_1111_1111111;
			endcase
			
		if(remain>=10)	// abcd_efg1g2_hjklmnp
			seg_2 = 15'b1001_1111_1111111;
		else
			seg_2 = 15'b1111_1111_1111111;
			
	end


endmodule
