`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:58:46 05/05/2015 
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
	input  [0:3] col,
    output [0:3] row,
    output [0:3] dig,
    output [0:14]seg,
    output audio_bck,
    output audio_ws,
    output audio_data,
    output audio_sysclk,
    output audio_appsel
    );
	 
	 reg [15:0] password = 16'd1234; 
	 
	 wire [3:0] valid;
	 wire [15:0] buffer;
	 wire isWrong;

	 wire rst_n;
	 wire clock_1MHz,clock_100KHz,clock_10KHz,clock_1KHz,clock_100Hz,clock_10Hz,clock_1Hz;
	 	 
	// clock divider
	clk_div c(clk, clock_1MHz, clock_100KHz, clock_10KHz, clock_1KHz, clock_100Hz, clock_10Hz, clock_1Hz);

	// Read out the four most recently pressed keys and record them in a buffer
	// keypad_scanner key_scan( .clk(clk_100), .resetn(resetn), .col(col[0:3]), .row(row), .buffer(buffer), .valid(valid));
	keypad_scanner k(clock_100Hz, !rst_n, password, col, row, buffer, valid, isWrong);

	//	Display 4 HEX digits on 14-segment displays
	display_ct d(clock_1KHz,buffer,valid,dig,seg);

	// Control buzzer
	node_controller n_c(clk, clock_100Hz, isWrong, audio_appsel, audio_sysclk, audio_bck, audio_ws, audio_data, rst_n);

	
endmodule
