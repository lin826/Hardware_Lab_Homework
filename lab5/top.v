`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:29:20 03/31/2015
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
module top (clk_40M,pb_1,pb_2,ctr, dig, seg);
	input clk_40M,ctr;
	input pb_1,pb_2;
	output  [0:3] dig;
	output  [0:14] seg;	// abcd efg1g2 hjklmnp
	wire [15:0] bcds;
	wire clk_1K,clk_10,clk_100;
	wire En2,En3,En4;
	reg En1=1'b0;
	wire pb1_debounced,pb2_debounced,pb1_single_pulse,pb2_single_pulse;

	// clock divider
	clk_div u1(.clock_40MHz(clk_40M), .clock_1MHz(), .clock_100KHz(), .clock_10KHz(), .clock_1KHz(clk_1K), .clock_100Hz(clk_100), .clock_10Hz(clk_10), .clock_1Hz());

	// display the bcds
	display_ct bch_decoder1(clk_1K, bcds,ctr, dig, seg);

	// the debounce and onepulse of the push buttoms
	debounce de_pb1(pb_1,clk_100, pb1_debounced),
				de_pb2(pb_2, , pb2_debounced);
	onepulse on_pb1(pb1_debounced, clk_100, pb1_single_pulse),
				on_pb2(pb2_debounced, clk_100, pb2_single_pulse);

	// time counter and change the bcds
	assign En2 = bcds[0] & bcds[3] & En1,
			 En3 = bcds[4] & bcds[7] & En2,
			 En4 = bcds[8] & bcds[11] & En3;
    bcd_ctr Counter1(clk_10, En1, !pb2_single_pulse,bcds[3:0]),
	        Counter2(clk_10, En2, !pb2_single_pulse,bcds[7:4]),
			  Counter3(clk_10, En3, !pb2_single_pulse,bcds[11:8]),
			  Counter4(clk_10, En4, !pb2_single_pulse,bcds[15:12]);

	// Start and Pause
	always @(negedge pb1_single_pulse)
	begin
		En1 <= ~En1;
	end


endmodule
