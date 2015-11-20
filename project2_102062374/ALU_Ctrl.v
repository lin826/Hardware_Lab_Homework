//Subject:     Architecture project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      102062374_I-Ju,Lin
//----------------------------------------------
//Final modification Date:        2015/05/02 11:30am by 102062374
//----------------------------------------------
//Description: 1.This is module of ALU controller, including lw,sw,beq,and,sub,and,or,slt.
//             2.add is for and, lw, sw.
//             3.sub is for sub, beq.
//----------------------------------------------
//Reference: http://www.eng.utah.edu/~cs6710/slides/mipsx2.pdf
//--------------------------------------------------------------------------------


module ALU_Ctrl(
    funct_i,
    ALUOp_i,
    ALUCtrl_o
);

//I/O ports
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output reg [4-1:0] ALUCtrl_o;

//Parameter
parameter AND = 4'b0000;
parameter OR  = 4'b0001;
parameter ADD = 4'b0010;
parameter SUB = 4'b0110;
parameter SLT = 4'b0111;

parameter ALU_op_Rtype = 3'b000;
parameter ALU_op_lwsw  = 3'b001;
parameter ALU_op_beq   = 3'b010;
parameter ALU_op_addi  = 3'b011;
parameter ALU_op_slti  = 3'b100;

parameter ADD_FUNC = 6'h20;
parameter SUB_FUNC = 6'h22;
parameter AND_FUNC = 6'h24;
parameter OR_FUNC  = 6'h25;
parameter SLT_FUNC = 6'h2a;

//Main function
always @(*)
begin
	case (ALUOp_i)
	ALU_op_Rtype:
		case (funct_i)
			ADD_FUNC: ALUCtrl_o = ADD;
			SUB_FUNC: ALUCtrl_o = SUB;
			AND_FUNC: ALUCtrl_o = AND;
			OR_FUNC:  ALUCtrl_o = OR;
			SLT_FUNC: ALUCtrl_o = SLT;
			default:  ALUCtrl_o = ADD;
		endcase
	ALU_op_lwsw : ALUCtrl_o = ADD;
	ALU_op_beq  : ALUCtrl_o = SUB;
	ALU_op_addi : ALUCtrl_o = ADD;
	ALU_op_slti : ALUCtrl_o = SLT;
	default: ALUCtrl_o = ALUCtrl_o;
	endcase
end

endmodule