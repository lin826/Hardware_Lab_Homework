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
module pre_btn(clk,pb,reset,pressed,rst_n);
	input clk;
	input [6:0]pb;
	input reset;
	output [6:0]pressed;
	output rst_n;
	debounce de_pb1(pb[0],clk, pressed[0]);
	debounce	de_pb2(pb[1],clk, pressed[1]);
	debounce	de_pb3(pb[2],clk, pressed[2]);
	debounce	de_pb4(pb[3],clk, pressed[3]);
	debounce	de_pb5(pb[4],clk, pressed[4]);
	debounce de_pb6(pb[5],clk, pressed[5]);
	debounce	de_pb7(pb[6],clk, pressed[6]);
	debounce de_rst(reset,clk, rst);
	assign rst_n = ~rst;
endmodule
