//Subject:     Architecture project 2 - Instruction Memory
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      102062374_I-Ju,Lin
//----------------------------------------------
//Final modification Date:        2015/05/02 13:30pm by 102062374
//----------------------------------------------
//Description: 1.This is module of instructure memory.
//----------------------------------------------
//Reference: 
//--------------------------------------------------------------------------------

module Instr_Memory(
   pc_addr_i,
	instr_o
	);
     
//I/O ports
input  [32-1:0]  pc_addr_i;
output [32-1:0]  instr_o;

//Internal Signals
reg    [32-1:0]  instr_o;
integer          i;

//32 words Memory
reg    [32-1:0]  Instr_Mem [0:32-1];

//Parameter

//Main function
always @(*) begin
	instr_o = Instr_Mem[pc_addr_i/4];
end
    
//Initial Memory Contents
initial begin
    for ( i=0; i<32; i=i+1 )
	    Instr_Mem[i] = 32'b0;
	
    $readmemb("testcase_4_2.txt", Instr_Mem);  //Read instruction from "testcase_4_2.txt"   
		
end
endmodule





                    
                    