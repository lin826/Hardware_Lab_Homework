`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:46:44 04/14/2015 
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
module top(clk_40M, btn_exit, btn_enter, dig, seg, LED);
	input   clk_40M,btn_exit,btn_enter;
	output  [0:3] dig;
	output  [0:14] seg;	// abcd efg1g2 hjklmnp
	output  LED;
	
	wire clk_1K,clk_10,clk_100,clk_1;
	wire [1:0]pressed;
	wire [3:0]remain;
	wire [1:0]moving;
			
	// clock divider
	clk_div clk_div(.clock_40MHz(clk_40M), .clock_1MHz(), .clock_100KHz(), .clock_10KHz(), .clock_1KHz(clk_1K), .clock_100Hz(clk_100), .clock_10Hz(clk_10), .clock_1Hz(clk_1));
	
	// the debounce and onepulse of the push buttoms
	Pre_btn btn(clk_100, btn_exit, btn_enter,pressed);
	
	// LED as an indicator when the garage is full
	LED_full full(clk_100, remain, LED);
	
	// control the entry, exist, and remain
	Control ctr(clk_100, pressed, moving, remain);
	
	// display two bar and the remain number
	Display dis(clk_1K, remain, dig, seg, moving);

endmodule
