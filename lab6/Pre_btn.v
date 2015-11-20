`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:23 04/09/2015 
// Design Name: 
// Module Name:    Pre_btn 
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
module Pre_btn(clk,pb,rst,pressed);
	input clk;
	input [3:0]pb;
	input rst;
	output [4:0]pressed;
	// the debounce and onepulse of the push buttoms
	wire [4:0]debounced;
	debounce de_pb1(pb[0],clk, debounced[0]),
				de_pb2(pb[1],clk, debounced[1]),
				de_pb3(pb[2],clk, debounced[2]),
				de_pb4(pb[3],clk, debounced[3]),
				de_rst(rst,clk, debounced[4]);
	onepulse on_pb1(debounced[0], clk, pressed[0]),
				on_pb2(debounced[1], clk, pressed[1]),
				on_pb3(debounced[2], clk, pressed[2]),
				on_pb4(debounced[3], clk, pressed[3]),
				on_rst(debounced[4], clk, pressed[4]);
endmodule
