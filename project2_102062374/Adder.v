//Subject:     Architecture project 2 - Adder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      102062374_I-Ju,Lin
//----------------------------------------------
//Final modification Date:        2015/05/02 11:30am by 102062374
//----------------------------------------------
//Description: 1.This is module of Adder. 
//             2.It contents a 32 bits adder that adds two binary numbers.
//--------------------------------------------------------------------------------

module Adder(
   src1_i,
	src2_i,
	sum_o
	);
     
	//I/O ports	
	input  [32-1:0]  src1_i;
	input  [32-1:0]	 src2_i;
	output [32-1:0]	 sum_o;

	//Internal Signals
	wire    [32-1:0]	 sum_o;

	//Parameter
    
	//Main function
	assign sum_o = src1_i + src2_i;
	
endmodule





                    
                    