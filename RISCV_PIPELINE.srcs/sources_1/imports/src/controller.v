module controller (
    reset,
	op,
	funct3D,
	funct3E,
	funct3M,
	funct7b5,
	Zero,
	Carry,
	Verflow,
	Negative,
	ResultSrc,
	MemWrite,
	PCSrc,
	ALUSrc,
	RegWrite,
	ImmSrc,
	ALUControl,
	LdType,
	StrType,
	BranchE,
	BranchD,
	JumpE,
	JumpD
);
    input wire reset;
	input wire [6:0] op;
	input wire [2:0] funct3D;
	input wire [2:0] funct3E;
	input wire [2:0] funct3M;
	input wire funct7b5;
	input wire Zero;
	input wire Carry;
	input wire Verflow;
	input wire Negative;
	output wire [2:0] ResultSrc;
	output wire MemWrite;
	output wire [1:0] PCSrc;
	output wire ALUSrc;
	output wire RegWrite;
	output wire [2:0] ImmSrc;
	output wire [3:0] ALUControl;
	output wire [2:0] LdType;
	output wire [2:0] StrType;
	wire [1:0] ALUOp;
	input wire BranchE;
	output wire BranchD;
	input wire [1:0] JumpE;
	output wire [1:0] JumpD;
	
	assign LdType=funct3D;
	assign StrType=funct3M;
	
	maindec md(
		.op(op),
		.ResultSrc(ResultSrc),
		.MemWrite(MemWrite),
		.Branch(BranchD),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.Jump(JumpD),
		.ImmSrc(ImmSrc),
		.ALUOp(ALUOp)
	);
	aludec ad(
		.opb5(op[5]),
		.funct3(funct3D),
		.funct7b5(funct7b5),
		.ALUOp(ALUOp),
		.ALUControl(ALUControl)
	);
	
	
	mux8 #(32) pcSrcMux(
		(BranchE & Zero) | JumpE[0],
		(BranchE & ~Zero) | JumpE[0],
		(BranchE) | JumpE[0],
		(BranchE) | JumpE[0],
		(BranchE & Negative ^ Verflow) | JumpE[0],
		(BranchE & ~(Negative ^ Verflow)) | JumpE[0],
		(BranchE & Carry) | JumpE[0],
		(BranchE & ~Carry) | JumpE[0],
		funct3E,
		PCSrc[0]
	);	
	
	assign PCSrc[1]=JumpE[1];
    
endmodule
