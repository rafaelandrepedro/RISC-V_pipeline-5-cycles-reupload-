module datapath (
	clk,
	reset,
	StallF,
	ResultSrc,
	PCSrc,
	ALUSrc,
	RegWrite,
	ImmSrc,
	ALUControl,
	Zero,
	Carry,
	Verflow,
	Negative,
	PC,
	PCE,
	Instr,
	ALUResult,
	ALUResultM,
	ALUResultW,
	WriteData,
	ReadData,
	LdStrType,
	PCPlus4,
	PCPlus4D,
	ImmExtD,
	ImmExtE,
	RdW,
    Rs2E,
    Rs1E,
    RdD,
    Rs2D,
    Rs1D,
    RD1D,
    RD2D,
    RD1E,
    RD2E,
    ForwardAE,
    ForwardBE
);
	input wire clk;
	input wire reset;
	
	input wire [1:0] ForwardAE;
	input wire [1:0] ForwardBE;
	
	input wire StallF;
	input wire [2:0] ResultSrc;
	input wire [1:0] PCSrc;
	input wire ALUSrc;
	input wire RegWrite;
	input wire [2:0] ImmSrc;
	input wire [3:0] ALUControl;
	output wire Zero;
	output wire Carry;
	output wire Verflow;
	output wire Negative;
	output wire [31:0] PC;
	input wire [31:0] PCE;
	input wire [31:0] Instr;
	output wire [31:0] ALUResult;
	input wire [31:0] ALUResultM;
	input wire [31:0] ALUResultW;
	output wire [31:0] WriteData;
	output wire [31:0] RD2D;
	input wire [31:0] RD2E;
	input wire [31:0] ReadData;
	input wire [2:0] LdStrType;
	wire [31:0] PCNext;
	output wire [31:0] PCPlus4;
	input wire [31:0] PCPlus4D;
	wire [31:0] PCTarget;
	wire [31:0] PCAbs;
	output wire [31:0] ImmExtD;
	input wire [31:0] ImmExtE;
	wire signed [31:0] SrcA;
	output wire signed [31:0] RD1D;
	input wire signed [31:0] RD1E;
	wire [31:0] SrcB;
	wire [31:0] Result;
	wire [31:0] PCImm;
	input wire [4:0] RdW;
    input wire [4:0] Rs2E;
    input wire [4:0] Rs1E;
    input wire [4:0] RdD;
    input wire [4:0] Rs2D;
    input wire [4:0] Rs1D;
	
	flopr #(32) pcreg(
		clk,
		reset,
		StallF,
		PCNext,
		PC
	);
	adder pcadd4(
		PC,
		32'd4,
		PCPlus4
	);
	adder pcaddbranch(
		PCE,
		ImmExtE,
		PCTarget
	);
	adder Regaddimm(
		SrcA,
		ImmExtE,
		PCAbs
	);
	adder PCaddimm(
		PCE,
		ImmExtE,
		PCImm
	);
	
    mux4 #(32) pcmux(
		PCPlus4,
		PCTarget,
		PCPlus4,
		PCAbs,
		PCSrc,
		PCNext
	);
	regfile rf(
		.clk(clk),
		.we3(RegWrite),
		.a1(Rs1D),
		.a2(Rs2D),
		.a3(RdW),
		.wd3(Result),
		.rd1(RD1D),
		.rd2(RD2D),
		.ResultSrc(ResultSrc),
		.LdStrType(LdStrType)
	);
	extend ext(
		Instr[31:7],
		ImmSrc,
		ImmExtD
	);
	mux2 #(32) srcbmux(
		WriteData,
		ImmExtE,
		ALUSrc,
		SrcB
	);
	alu alu(
		.SrcA(SrcA),
		.SrcB(SrcB),
		.ALUControl(ALUControl),
		.ALUResult(ALUResult),
		.Zero(Zero),
		.Carry(Carry),
		.Verflow(Verflow),
		.Negative(Negative)
	);
	mux5 #(32) resultmux(  
		ALUResultW,
		ReadData,
		PCPlus4D,
		ImmExtE,
		PCImm,
		ResultSrc,
		Result
	);
	
	mux3 #(32) AEmux(
		RD1E,
		Result,
		ALUResultM,
		ForwardAE,
		SrcA
	);
	mux3 #(32) BEmux(  
		RD2E,
		Result,
		ALUResultM,
		ForwardBE,
		WriteData
	);
	
endmodule
