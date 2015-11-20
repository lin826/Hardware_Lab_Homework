//Subject:     Architecture project 2 - Sign extend
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Sign_Extend(
    data_i,
    data_o
    );
               
//I/O ports
input   [16-1:0] data_i;
output  [32-1:0] data_o;

//Internal Signals
reg     [32-1:0] data_o;
wire 	  sign_w;
integer i;

assign sign_w = data_i[16-1];

//Sign extended
always @(*) begin
	data_o[16-1:0] <= data_i;
	for( i=32-1; i>=16; i=i-1 )
		data_o[i] <= sign_w;
end
        
endmodule      
     