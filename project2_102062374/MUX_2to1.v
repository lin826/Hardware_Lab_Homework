//Subject:     Architecture project 2 - MUX 221
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      102062374_I-Ju,Lin
//----------------------------------------------
//Final modification Date:        2015/05/02 11:30am by 102062374
//----------------------------------------------
//Description: 1.This is module of MUX_2to1.
//--------------------------------------------------------------------------------
     
module MUX_2to1(
               data0_i,
               data1_i,
               select_i,
               data_o
               );

parameter size = 0;			   
			
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input              select_i;
output  [size-1:0] data_o; 

//Internal Signals
wire     [size-1:0] data_o;

//Main function
assign data_o = select_i ? data1_i: data0_i;

endmodule      
          
          