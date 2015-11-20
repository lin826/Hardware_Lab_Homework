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
  input [0:3] col,
  output [0:3] row,
  output [15:0] buffer,	// buffer[3:0] records the BCH of the last key pressed, etc.
 
	output  [0:3] dig,	//4 pins to control four digits
	output  [0:14] seg	//

  ); 
	
	wire [3:0] valid;
	wire clock_1MHz,clock_100KHz,clock_10KHz,clock_1KHz,clock_100Hz,clock_10Hz,clock_1Hz;
	
	reg resetn = 1'b0;

	// clock divider
	clk_div c(clk, clock_1MHz, clock_100KHz, clock_10KHz, clock_1KHz, clock_100Hz, clock_10Hz, clock_1Hz);

	// Read out the four most recently pressed keys and record them in a buffer
	// keypad_scanner key_scan( .clk(clk_100), .resetn(resetn), .col(col[0:3]), .row(row), .buffer(buffer), .valid(valid));
	keypad_scanner k(clock_100Hz, resetn, col, row, buffer, valid);

	//	Display 4 HEX digits on 14-segment displays
	display_ct d(clock_1KHz,buffer,valid,dig,seg);

endmodule
