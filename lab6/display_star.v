`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:39:40 04/07/2015 
// Design Name: 
// Module Name:    display_star 
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
module display_star(clk,blk,str,over, dig, seg);
	input clk;
	input over;
	input [3:0]blk,str;
	output reg [0:3] dig;
	output reg [0:14] seg;	// abcd efg1g2 hjklmnp
	
	wire [0:14]seg_0,seg_1,seg_2,seg_3;
	reg [3:0]count;
	reg [2:0]place;
	
	parameter 
		STAR = 15'b1111_1100_0000001,
		BLOCK = 15'b0000_0000_0000001,
		DARK = 15'b1111_1111_1111111,
		O = 15'b0000_0011_1111111,
		V = 15'b1000_0011_1111111,
		E = 15'b0110_0000_1111111,
		R = 15'b0011_0000_1111100;
	
	assign seg_0=over?R:(str[0]?(blk[0]?BLOCK:STAR):DARK),
			 seg_1=over?E:(str[1]?(blk[1]?BLOCK:STAR):DARK),
			 seg_2=over?V:(str[2]?(blk[2]?BLOCK:STAR):DARK),
			 seg_3=over?O:(str[3]?(blk[3]?BLOCK:STAR):DARK);
		
	always @(posedge clk)
	begin
		seg = 15'b1111_1111_1111111;
		case(count)
		4'b1110:
			begin
			dig <= 4'b1110;
			seg = seg_0;
			count <= 4'b1101;
			end
		4'b1101: 
			begin
			dig <= 4'b1101;
			seg = seg_1;
			count <= 4'b1011;
			end
		4'b1011: 
			begin
			dig <= 4'b1011;
			seg = seg_2;
			count <= 4'b0111;
			end
		4'b0111: 
			begin
			dig <= 4'b0111;
			seg = seg_3;
			count <= 4'b1110;
			end
		default: count <= 4'b1110;
		endcase
	end
	
endmodule
	
	