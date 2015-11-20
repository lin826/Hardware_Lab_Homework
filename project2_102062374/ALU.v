//Subject:     Architecture project 2 - ALU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      102062374_I-Ju,Lin
//----------------------------------------------
//Final modification Date:        2015/05/02 13:30pm by 102062374
//----------------------------------------------
//Description: 1.This is module of ALU core. It contents the core of ALU.
//             2.Give the result of ALU depends on control signal.
//----------------------------------------------
//Reference: http://www.eng.utah.edu/~cs6710/slides/mipsx2.pdf
//--------------------------------------------------------------------------------

module ALU(
   src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
	//I/O ports
	input  [32-1:0]  src1_i;
	input  [32-1:0]  src2_i;
	input  [4-1:0]   ctrl_i;

	output [32-1:0]  result_o;
	output           zero_o;

	//Internal signals
	reg    [32-1:0]  result_o;
	wire             zero_o;
	assign zero_o = ((src1_i - src2_i)== 0)?1:0;
	//wire   [32-1:0]  b2, sum, slt; 

	//Parameter
	parameter AND = 4'b0000;
	parameter OR  = 4'b0001;
	parameter ADD = 4'b0010;
	parameter SUB = 4'b0110;
	parameter SLT = 4'b0111;
	
	//Main function
	//assign b2 = ctrl_i[2] ? ~src2_i:src2_i;
	//assign sum = src1_i + b2 + ctrl_i[2];
	// slt should be 1 if most significant bit of sum is 1
	//assign slt = sum[32-1];
	
	always@(*)
		case(ctrl_i)
		4'b0000: result_o <= src1_i & src2_i; // and
		4'b0001: result_o <= src1_i | src2_i; // or
		4'b0010:  result_o =(src1_i + src2_i) ;
		4'b0110: result_o =(src1_i - src2_i) ;
		4'b0111: 
			begin
					if(src1_i < src2_i)
						result_o = 1'b1;
					else
						result_o = 1'b0;
			end
		default:;
		endcase
		
endmodule





                    
                    