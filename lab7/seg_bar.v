`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:03:14 04/14/2015 
// Design Name: 
// Module Name:    seg_bar 
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
module seg_bar(clk, move, seg, moving);
	input clk;
	input move;
	output reg [0:14]seg = STATE_0;
	output reg moving;
	
	reg [9:0] count;
	reg [0:14] pre_seg;
	reg [1:0]state = 2'b00;
	
	parameter STATE_0 = 15'b1111_1110_1110111,
				STATE_1 = 15'b1111_1111_1100111,
				STATE_2 = 15'b1111_1111_1010111;	
				
	initial  moving = 1'b0;
	
	always @(posedge clk)
	begin
		if(move)	
		begin
			moving <= 1'b1;
			pre_seg <= seg;
		end
		
		if(moving)
		begin
			//animation
			if(count>500)
			begin
				case(state)
					2'b00: seg <= STATE_1;
					2'b01: seg <= STATE_2;
					2'b10: seg <= STATE_1;
					2'b11: 
						begin 
							seg <= STATE_0;
							moving <= 1'b0;
						end
					default:seg <= STATE_0;
				endcase				
				state <= state + 1'b1;
				count <= 10'b0;
			end
			else count <= count + 1'b1;
		end
	end


endmodule
