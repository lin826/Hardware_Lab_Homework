`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:54 05/05/2015 
// Design Name: 
// Module Name:    node_controller 
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
module node_controller(clk, clock_100Hz, isWrong, audio_appsel, audio_sysclk, audio_bck, audio_ws, audio_data, cancel);
	input clk, clock_100Hz, isWrong;
	output audio_bck;
   output audio_ws;
   output audio_data;
   output audio_sysclk;
   output audio_appsel;
	output reg cancel;
	
	reg  rst_n = 1'b0;
	wire [6:0]  pressed;
	wire [15:0] audio_left,audio_right;
	reg  [19:0] note_div_ns;
	wire [19:0] note_div;
	
	initial cancel = 1'b0;
	initial note_div_ns = 20'd0;
	
	assign note_div = note_div_ns;
	
	always @(posedge clock_100Hz)
	begin
		if(isWrong)
		begin
			if (note_div == 20'd0) 
			begin
				note_div_ns <= 20'd68027; // State_2 : Re
				rst_n <= 1'b0;
			end
			else
			begin
				note_div_ns <= 20'd57307; // State_1 : Fa
				rst_n <= 1'b0;
			end
		end
		else 
		begin
			rst_n <= 1'b0;
			note_div_ns <= 20'd0;
			cancel <= 1'b0;
		end
	end
			
	note_generator n_g(clk, rst_n, note_div, audio_left, audio_right);
	
	buzzer_control b_c(clk, rst_n, audio_left, audio_right, audio_appsel, audio_sysclk, audio_bck, audio_ws, audio_data);

endmodule
