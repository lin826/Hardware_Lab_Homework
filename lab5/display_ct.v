`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:57:50 03/24/2015 
// Design Name: 
// Module Name:    display_ct 
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
module display_ct(clk, bcds,ctr, dig, seg);
	input clk;
	input [15:0] bcds;
	input ctr;
	output reg [0:3] dig;
	output reg [0:14] seg;	// abcd efg1g2 hjklmnp
	
	reg [3:0]count;
	
	//always @(negedge clk)	count <= 4'b1110;
	
	always @(posedge clk)
	begin
		case(count)
		4'b1110:
			begin
			dig <= 4'b1110;
			case (bcds[3:0])	// abcd_efg1g2_hjklmnp
			4'h0: seg = 15'b0000_0011_1100111;
			4'h1: seg = 15'b1001_1111_1111111;
			4'h2: seg = 15'b0010_0100_1111111;
			4'h3: seg = 15'b0000_1100_1111111;
			4'h4: seg = 15'b1001_1000_1111111;
			4'h5: seg = 15'b0100_1000_1111111;
			4'h6: seg = 15'b0100_0000_1111111;
			4'h7: seg = 15'b0001_1111_1111111;
			4'h8: seg = 15'b0000_0000_1111111;
			4'h9: seg = 15'b0000_1000_1111111;
			default: seg = 15'b1111_1111_1111111;
			endcase
			count <= 4'b1101;
			end
		4'b1101: 
			begin
			dig <= 4'b1101;
			case (bcds[7:4])	// abcd_efg1g2_hjklmnp
			4'h0: seg = 15'b0000_0011_1100110;
			4'h1: seg = 15'b1001_1111_1111110;
			4'h2: seg = 15'b0010_0100_1111110;
			4'h3: seg = 15'b0000_1100_1111110;
			4'h4: seg = 15'b1001_1000_1111110;
			4'h5: seg = 15'b0100_1000_1111110;
			4'h6: seg = 15'b0100_0000_1111110;
			4'h7: seg = 15'b0001_1111_1111110;
			4'h8: seg = 15'b0000_0000_1111110;
			4'h9: seg = 15'b0000_1000_1111110;
			default: seg = 15'b1111_1111_1111111;
			endcase
			count <= 4'b1011;
			end
		4'b1011: 
			begin
			dig <= 4'b1011;
			case (bcds[11:8])	// abcd_efg1g2_hjklmnp
			4'h0: seg = 15'b0000_0011_1100111;
			4'h1: seg = 15'b1001_1111_1111111;
			4'h2: seg = 15'b0010_0100_1111111;
			4'h3: seg = 15'b0000_1100_1111111;
			4'h4: seg = 15'b1001_1000_1111111;
			4'h5: seg = 15'b0100_1000_1111111;
			4'h6: seg = 15'b0100_0000_1111111;
			4'h7: seg = 15'b0001_1111_1111111;
			4'h8: seg = 15'b0000_0000_1111111;
			4'h9: seg = 15'b0000_1000_1111111;
			default: seg = 15'b1111_1111_1111111;
			endcase
			count <= 4'b0111;
			end
		4'b0111: 
			begin
			dig <= 4'b0111;
			case (bcds[15:12])	// abcd_efg1g2_hjklmnp
			4'h0: seg = 15'b0000_0011_1100111;
			4'h1: seg = 15'b1001_1111_1111111;
			4'h2: seg = 15'b0010_0100_1111111;
			4'h3: seg = 15'b0000_1100_1111111;
			4'h4: seg = 15'b1001_1000_1111111;
			4'h5: seg = 15'b0100_1000_1111111;
			4'h6: seg = 15'b0100_0000_1111111;
			4'h7: seg = 15'b0001_1111_1111111;
			4'h8: seg = 15'b0000_0000_1111111;
			4'h9: seg = 15'b0000_1000_1111111;
			default: seg = 15'b1111_1111_1111111;
			endcase
			count <= 4'b1110;
			end
		default: count <= 4'b1110;
		endcase
	end

	parameter BCD0 = 15'b0000_0011_1100111,
		BCD1 = 15'b1001_1111_1111111,
		BCD2 = 15'b0010_0100_1111111,
		BCD3 = 15'b0000_1100_1111111,
		BCD4 = 15'b1001_1000_1111111,
		BCD5 = 15'b0100_1000_1111111,
		BCD6 = 15'b0100_0000_1111111,
		BCD7 = 15'b0001_1111_1111111,
		BCD8 = 15'b0000_0000_1111111,
		BCD9 = 15'b0000_1000_1111111,
		DARK = 15'b1111_1111_1111111;

	endmodule
