//Subject:     Architecture project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:
//----------------------------------------------
//Date:
//----------------------------------------------
//Description:
//--------------------------------------------------------------------------------

module Decoder(
	 instr_op_i,
	 RegDst_o,
	 ALUSrc_o,
	 MemtoReg_o,
	 RegWrite_o,
	 MemRead_o,
	 MemWrite_o,
	 Branch_o,
	 ALUop_o,
    );

//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALUop_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output         MemtoReg_o;
output         MemRead_o;
output         MemWrite_o;

//Internal Signals
wire RegDst_o,
	 ALUSrc_o,
	 MemtoReg_o,
	 RegWrite_o,
	 MemRead_o,
	 MemWrite_o,
	 Branch_o;
wire [3-1:0] ALUop_o;

//Parameter
parameter R_type = 6'b000000;
parameter lw = 6'b100011;
parameter sw = 6'b101011;
parameter beq = 6'b000100;
parameter addi = 6'h8;
parameter slti = 6'ha;  

parameter ALU_op_Rtype = 3'b000;
parameter ALU_op_lwsw  = 3'b001;
parameter ALU_op_beq   = 3'b010;
parameter ALU_op_addi  = 3'b011;
parameter ALU_op_slti  = 3'b100;

//Main function
assign	RegDst_o   = (instr_op_i == R_type || instr_op_i == beq || instr_op_i == sw);
assign	ALUSrc_o   = (instr_op_i == lw || instr_op_i == sw || instr_op_i == addi || instr_op_i == slti);
assign	MemtoReg_o = (instr_op_i == lw);
assign	RegWrite_o = (instr_op_i == lw || instr_op_i == R_type || instr_op_i == addi || instr_op_i == slti);
assign	MemRead_o  = (instr_op_i == lw);
assign	MemWrite_o = (instr_op_i == sw);
assign	Branch_o   = (instr_op_i == beq);
assign	ALUop_o    = (instr_op_i == lw || instr_op_i == sw) ? ALU_op_lwsw :
						(instr_op_i == beq) ? ALU_op_beq : 
						(instr_op_i == addi) ? ALU_op_addi :
						(instr_op_i == slti) ? ALU_op_slti : ALU_op_Rtype;	

endmodule







