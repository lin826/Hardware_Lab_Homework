//Subject:     Architecture project 2 - Simple Single CPU
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
      clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles

// Adder
wire [32-1:0] add2_src2_i;

// Controllers
wire RegDst,
	  ALUSrc,
	  MemtoReg,
	  RegWrite,
	  MemRead,
	  MemWrite,
	  Branch;
wire [3-1:0] ALU_op;
	  
// PC
wire [32-1:0] pc_in_i,
              pc_in_ns,
				  add2_o,
              pc_out_o;

// Instruction memory
wire [32-1:0] Instr_w;

// Register
wire [5-1:0]  RDaddr_i;
wire [32-1:0] RDdata_i;
wire [32-1:0] RSdata_o,RTdata_o;

// Signed extend
wire [32-1:0] SEdata_o;

// ALU
wire [32-1:0] ALUsrc2_i,ALUresult_o;
wire [4-1:0]  ALUCtrl_o;
wire ALU_Zero;

// Data memory
wire [32-1:0] Mem_data_o;

// PC Source
wire PCSrc;
assign PCSrc = ALU_Zero && Branch;

//Greate componentes
ProgramCounter PC(
       .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in_i) ,   
	    .pc_out_o(pc_out_o) 
	    );
	
Adder Adder1(
       .src1_i(pc_out_o),     
	    .src2_i(4),     
	    .sum_o(pc_in_ns)    
	    );
	
Instr_Memory IM(
       .pc_addr_i(pc_out_o),  
	    .instr_o(Instr_w)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(Instr_w[20:16]),
        .data1_i(Instr_w[15:11]),
        .select_i(RegDst),
        .data_o(RDaddr_i)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
		  .rst_i(rst_i) ,     
        .RSaddr_i(Instr_w[25:21]) ,  
        .RTaddr_i(Instr_w[20:16]) ,  
        .RDaddr_i(RDaddr_i) ,  
        //.RDdata_i(ALUresult_o),
		  .RDdata_i(RDdata_i)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );

Decoder Decoder(
       .instr_op_i(Instr_w[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALUop_o(ALU_op),  
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		 .Branch_o(Branch),
		 .MemtoReg_o(MemtoReg),
		 .MemRead_o(MemRead),
		 .MemWrite_o(MemWrite)
	    );

ALU_Ctrl AC(
        .funct_i(Instr_w[5:0]),   
        .ALUOp_i(ALU_op),
        .ALUCtrl_o(ALUCtrl_o) 
        );
	
Sign_Extend SE(
        .data_i(Instr_w[15:0]),
        .data_o(SEdata_o)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata_o),
        .data1_i(SEdata_o),
        .select_i(ALUSrc),
        .data_o(ALUsrc2_i)
        );	
		
ALU ALU(
       .src1_i(RSdata_o),
	    .src2_i(ALUsrc2_i),
	    .ctrl_i(ALUCtrl_o),
	    .result_o(ALUresult_o),
		 .zero_o(ALU_Zero)
	    );

Data_Memory DM
(
	.clk_i(clk_i),
	.addr_i(ALUresult_o),
	.data_i(RTdata_o),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(Mem_data_o)
);

MUX_2to1 #(.size(32)) Mux_MemtoReg(
        .data0_i(ALUresult_o),
        .data1_i(Mem_data_o),
        .select_i(MemtoReg),
        .data_o(RDdata_i)
        );	
	
Adder Adder2(
       .src1_i(pc_in_ns),     
	    .src2_i(add2_src2_i),     
	    .sum_o(add2_o)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(SEdata_o),
        .data_o(add2_src2_i)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_in_ns),
        .data1_i(add2_o),
        .select_i(PCSrc),
        .data_o(pc_in_i)
        );	

endmodule
		  


