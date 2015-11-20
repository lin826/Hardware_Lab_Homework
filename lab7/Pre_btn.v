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
module Pre_btn(clk,pb0,pb1,pressed);
	input clk;
	input pb0,pb1;
	output [1:0]pressed;
	// the debounce and onepulse of the push buttoms
	wire [4:0]debounced;
	debounce de_pb1(pb0,clk, debounced[0]),
				de_pb2(pb1,clk, debounced[1]);
	onepulse on_pb1(debounced[0], clk, pressed[0]), //exit
				on_pb2(debounced[1], clk, pressed[1]); //entry
endmodule
