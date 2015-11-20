`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    11:26:33 04/09/2015
// Design Name:
// Module Name:    Check
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
module Check(clk,rst,str,pres,block,over);
	input clk,rst;
	input [3:0] str,pres;
	output reg [3:0]block;
	output reg over;

	reg [3:0] same = 4'b0000;
	reg [3:0] pre_str;
	reg [9:0] present_num;
	wire [9:0] next_num;

	assign next_num = present_num + 10'b1;
	initial present_num <= 10'b0;
	initial block <= 4'b0000;
	initial pre_str <= str;

	always @(posedge clk)
	begin
		// wether restart
		if(rst==1'b1)
			begin
				over <= 1'b0;
				block <= 4'b0000;
				present_num <= 10'b0;
				same <= 4'b0000;
				pre_str <= str;
			end

		// perform reset pattern
		/*else if(present_num < 10'b1000_0000_00)
		begin
			block <= block + 1'b1;
			present_num <= next_num; // counter continue
		end*/

		// consider wether catch the star in time
		else if(str!=pre_str && over!=1'b1)
			begin
				//present_num <= 10'b0; // reset counter
				over <= (same==4'b1111) ? 1'b0 : 1'b1 ;
				same <= 4'b0000; // reset the check varible
				block <= 4'b0000;
				pre_str <= str;
			end

		// wether catch star
		else if(over!=1'b1)
			begin
				if(str[0]==pres[0]) begin same[0] <= 1'b1; if(pres[0]) block[0] <= 1'b1; end
				if(str[1]==pres[1]) begin same[1] <= 1'b1; if(pres[1]) block[1] <= 1'b1; end
				if(str[2]==pres[2]) begin same[2] <= 1'b1; if(pres[2]) block[2] <= 1'b1; end
				if(str[3]==pres[3]) begin same[3] <= 1'b1; if(pres[3]) block[3] <= 1'b1; end
			end
	end



endmodule





