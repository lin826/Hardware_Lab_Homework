`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:24 04/07/2015 
// Design Name: 
// Module Name:    top 
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
module top(clk_40M, pb, rst, dig, seg);
	input   clk_40M,rst;
	input   [3:0] pb;
	output  [0:3] dig;
	output  [0:14] seg;	// abcd efg1g2 hjklmnp
	
	wire clk_1K,clk_10,clk_100,clk_1;
	wire [4:0]pressed;
	wire [3:0]stars;
	wire [3:0]block;
	wire over;
			
	// clock divider
	clk_div clk_div(.clock_40MHz(clk_40M), .clock_1MHz(), .clock_100KHz(), .clock_10KHz(), .clock_1KHz(clk_1K), .clock_100Hz(clk_100), .clock_10Hz(clk_10), .clock_1Hz(clk_1));
	
	// the debounce and onepulse of the push buttoms
	Pre_btn btn(clk_100,pb,rst,pressed);
	
	// lose or reset or continue
	Check(clk_100,pressed[4],stars[3:0],pressed[3:0],block[3:0],over);
	
	display_star dis(clk_1K,block[3:0],stars[3:0],over, dig, seg);
	Rand rand(clk_1,!pressed[4],stars[3:0]);
	//bcd_ctr rand(clk_1,!pressed[4],!pressed[4],stars[3:0]);

endmodule

