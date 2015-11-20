`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:44:24 04/21/2015
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
module top(
    input clk,
    input reset,
    input [6:0]pb,
    output audio_bck,
    output audio_ws,
    output audio_data,
    output audio_sysclk,
    output audio_appsel
  );

	wire [15:0] audio_left,audio_right;
	wire rst_n;
	wire [6:0]  pressed;
	wire [19:0] note_div;
	wire clock_1MHz,clock_100KHz,clock_10KHz,clock_1KHz,clock_100Hz,clock_10Hz,clock_1Hz;

	// clock divider
	clk_div c_d(clk, clock_1MHz, clock_100KHz, clock_10KHz, clock_1KHz, clock_100Hz, clock_10Hz, clock_1Hz);
	
	// debounced
	pre_btn p_b(clock_100Hz, pb, reset, pressed, rst_n);
	
	// note_div controller
	node_div_controller n_d_c(clock_100Hz, rst_n, pressed, note_div);
	
	note_generator n_g(clk, rst_n, note_div, audio_left, audio_right);
	
	buzzer_control b_c(clk, rst_n, audio_left, audio_right, audio_appsel, audio_sysclk, audio_bck, audio_ws, audio_data);

endmodule
