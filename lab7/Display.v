`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:45:57 04/14/2015 
// Design Name: 
// Module Name:    Display 
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
module Display(clk, remain, dig, seg, moving);
	input clk;
	input [3:0]remain;
	output reg [3:0] dig;
	output reg [0:14] seg;	// abcd efg1g2 hjklmnp
	output [1:0] moving;
	
	reg entry,exit;
	reg [3:0]pre_remain,count;
	
	wire [0:14] seg_0,seg_1,seg_2,seg_3;
	
	seg_bar in(clk, entry, seg_3, moving[1]);
	seg_bar out(clk, exit, seg_0, moving[0]);
	seg_remain(clk, remain, seg_1, seg_2);
	
	initial pre_remain = 4'b1100;
	
	always @(posedge clk)
	begin
		// Entry
		if(pre_remain > remain) entry<=1'b1;
		else entry<=1'b0;
	
		// Exit
		if(pre_remain < remain) exit<=1'b1;
		else exit<=1'b0;
		
		pre_remain <= remain;
	end
	
	// display four digit
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
