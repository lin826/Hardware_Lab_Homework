`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:07:12 05/11/2015 
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
	input rst_n,
	input  [0:3] col,
    output [0:3] row,
	output [7:0] LCD_data,
	output LCD_en,
	output LCD_rw,
	output LCD_rstn,
	output LCD_cs1,
	output LCD_cs2,
	output LCD_di
    );
	 
	wire clock_1MHz,clock_100KHz,clock_10KHz,clock_1KHz,clock_100Hz,clock_10Hz,clock_1Hz;
	wire [1:0] vir,hor;
	
	// clock divider
	clk_div c(clk, clock_1MHz, clock_100KHz, clock_10KHz, clock_1KHz, clock_100Hz, clock_10Hz, clock_1Hz);
	
	keypad_scanner k(clock_100Hz, !rst_n, password, col, row, vir, hor);
	
	PAC_MAN man(.LCD_CLK(clock_1MHz), .RESETN(!rst_n), .vir(vir), .hor(hor), .LCD_DATA(LCD_data), .LCD_ENABLE(LCD_en),
       .LCD_RW(LCD_rw), .LCD_RSTN(LCD_rstn), .LCD_CS1(LCD_cs1), .LCD_CS2(LCD_cs2), .LCD_DI(LCD_di));

endmodule
