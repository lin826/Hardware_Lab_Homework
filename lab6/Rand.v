`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:33 04/09/2015 
// Design Name: 
// Module Name:    Rand 
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
module Rand(clk,reset,stars);
	input clk;
	input reset;
	output reg[3:0]stars;
	
	// Randomizer
	wire linear_feedback;
	reg [15:0] rand;
	
	parameter SEED = 16'd97;
	
	assign linear_feedback = (rand[7] ^ rand[3])	;
	
	always @(posedge clk or negedge reset) 
	begin
		if(~reset)
			rand <= SEED;
		else 
			rand <= {rand[14:0], linear_feedback};		
	end
	
	always @(posedge clk or negedge reset) 
	begin
		case(rand[1:0])
			2'b00: stars <= /*(stars==4'b0001)?4'b0010:*/4'b0001;
			2'b01: stars <= /*(stars==4'b0010)?4'b0100:*/4'b0010;
			2'b10: stars <= /*(stars==4'b0100)?4'b1000:*/4'b0100;
			2'b11: stars <= /*(stars==4'b1000)?4'b0001:*/4'b1000;
		endcase
	end
endmodule