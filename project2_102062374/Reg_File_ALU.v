//Subject:     CO project 2 - Register File
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      102062374_I-Ju,Lin
//----------------------------------------------
//Final modification Date:        2015/05/02 13:30pm by 102062374
//----------------------------------------------
//Description: 1.This is module of registers.
//             2. .
//             3. .
//----------------------------------------------
//Reference: 
//--------------------------------------------------------------------------------
module Reg_File_ALU(
    clk_i,
	 rst_i,
    RSaddr_i,
    RTaddr_i,
    RDaddr_i,
    RDdata_i,
    RegWrite_i,
    RSdata_o,
    RTdata_o
    );
          
//I/O ports
input           clk_i;
input           rst_i;
input           RegWrite_i;
input  [5-1:0]  RSaddr_i;
input  [5-1:0]  RTaddr_i;
input  [5-1:0]  RDaddr_i;
input  [32-1:0] RDdata_i;

output [32-1:0] RSdata_o;
output [32-1:0] RTdata_o;   

//Internal signals/registers           
reg  signed [32-1:0] Reg_File [0:32-1];     //32 word registers
wire        [32-1:0] RSdata_o;
wire        [32-1:0] RTdata_o;

//Read the data
assign RSdata_o = Reg_File[RSaddr_i] ;
assign RTdata_o = Reg_File[RTaddr_i] ;   

//Writing data when postive edge clk_i and RegWrite_i was set.
always @( negedge rst_i or posedge clk_i  ) begin
    if(rst_i == 0) begin
	    Reg_File[0]  <= 0; 			Reg_File[1]  <= 0; 		Reg_File[2]  <= 32'd10; Reg_File[3]  <= 0;
	    Reg_File[4]  <= 32'd3; 	Reg_File[5]  <= 32'd9; 	Reg_File[6]  <= 32'd12; Reg_File[7]  <= 0;
       Reg_File[8]  <= 32'd5; 	Reg_File[9]  <= 32'd7; 	Reg_File[10] <= 0; 		Reg_File[11] <= 32'd4;
	    Reg_File[12] <= 32'd1; 	Reg_File[13] <= 32'd2; 	Reg_File[14] <= 0; 		Reg_File[15] <= 0;
       Reg_File[16] <= 0; 			Reg_File[17] <= 0; 		Reg_File[18] <= 32'd39; Reg_File[19] <= 0;      
       Reg_File[20] <= 0; 			Reg_File[21] <= 0; 		Reg_File[22] <= 0; 		Reg_File[23] <= 0;
       Reg_File[24] <= 32'd20;	Reg_File[25] <= 32'd799;Reg_File[26] <= 0; 		Reg_File[27] <= 0;
       Reg_File[28] <= 0; 			Reg_File[29] <= 32'd27; Reg_File[30] <= 0; 		Reg_File[31] <= 0;
	 end
    else begin
        if(RegWrite_i) 
            Reg_File[RDaddr_i] <= RDdata_i;	
		else 
		    Reg_File[RDaddr_i] <= Reg_File[RDaddr_i];
	 end
end

endmodule     





                    
                    