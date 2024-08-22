module riscvsingle (
	clk,
	reset,
	PC,
	Instr,
	MemWriteM,
	ALUResultM,
	WriteDataM,
	ReadDataM,
	StrType
);
	input wire clk;
	input wire reset;
	
	
	wire [1:0] ForwardAE;
	wire [1:0] ForwardBE;
	
	
	wire StallF;
	wire [31:0] PCD;
	wire [31:0] PCE;
	input wire [31:0] Instr;
	
	wire [31:0] ALUResultE;
	output wire [31:0] ALUResultM;
	wire [31:0] ALUResultW;
	wire [31:0] WriteDataE;
	output wire [31:0] WriteDataM;
	wire [2:0] LdType;
	output wire [2:0] StrType;
	input wire [31:0] ReadDataM;
	wire [31:0] ReadDataW;
	
	wire [1:0] Jump;
	wire Zero;
	wire Carry;
	wire Verflow;
	wire Negative;
	
	wire [2:0] ImmSrc;
	
	wire [1:0] PCSrc;
	
	wire StallD;
	wire FlushD;
	wire FlushE;
	wire [31:0] InstrD;
	output wire [31:0] PC;
	wire [31:0] PCPlus4;
	wire [31:0] PCPlus4D;
	wire [31:0] PCPlus4E;
	wire [31:0] PCPlus4M;
	wire [31:0] PCPlus4W;
	wire [4:0] RdE;
	wire [4:0] RdM;
	wire [4:0] RdW;
    wire [4:0] Rs2E;
    wire [4:0] Rs1E;
    
    wire ALUSrcD;
    wire ALUSrcE;
    
    wire [3:0] ALUControlD;
    wire [3:0] ALUControlE;
    
    wire BranchD;
    wire BranchE;
    
    wire [1:0] JumpD;
    wire [1:0] JumpE;
    
    wire RegWriteD;
    wire RegWriteE;
    wire RegWriteM;
    wire RegWriteW;
    
    wire [2:0] ResultSrcD;
    wire [2:0] ResultSrcE;
    wire [2:0] ResultSrcM;
    wire [2:0] ResultSrcW;
    
    wire [2:0] funct3E;
    wire [2:0] funct3M;
    
    output wire MemWriteM;
    wire MemWriteE;
    wire MemWriteD;
    
    
    wire [31:0] RD1D;
    wire [31:0] RD2D;
    wire [31:0] RD1E;
    wire [31:0] RD2E;
    
    
	wire [31:0] ImmExtD;
	wire [31:0] ImmExtE;
	
	controller c(
		reset,
		InstrD[6:0],
		InstrD[14:12],
		funct3E,
		funct3M,
		InstrD[30],
		Zero,
		Carry,
		Verflow,
		Negative,
		ResultSrcD,
		MemWriteD,
		PCSrc,
		ALUSrcD,
		RegWriteD,
		ImmSrc,
		ALUControlD,
		LdType,
		StrType,
        BranchE,
        BranchD,
        JumpE,
        JumpD
	);
	datapath dp(
		clk,
		reset,
		StallF,
		ResultSrcW,
		PCSrc,
		ALUSrcE,
		RegWriteW,
		ImmSrc,
		ALUControlE,
		Zero,
		Carry,
		Verflow,
		Negative,
		PC,
		PCE,
		InstrD,
		ALUResultE,
		ALUResultM,
		ALUResultW,
		WriteDataE,
		ReadDataW,
		LdType,
		PCPlus4,
		PCPlus4W,
		ImmExtD,
		ImmExtE,
		RdW,
        Rs2E,
        Rs1E,
        InstrD[11:7],
        InstrD[24:20],
        InstrD[19:15],
        RD1D,
        RD2D,
        RD1E,
        RD2E,
        ForwardAE,
        ForwardBE
	);
	
	hazardunit hu(
		clk,
        reset,
        
        StallF,
        StallD,
        FlushD,
        FlushE,
        ForwardAE,
        ForwardBE,
        
        InstrD[19:15],
        InstrD[24:20],
        RdE,
        Rs1E,
        Rs2E,
        PCSrc,
        ResultSrcE,
        RdM,
        RegWriteM,
        RdW,
        RegWriteW
	);
	
	pipelineregD prD(
	clk,
    reset,
    StallD,
    FlushD,
    
    Instr,
    PC,
    PCPlus4,
    
    InstrD,
    PCD,
    PCPlus4D
	);
	
	pipelineregE prE(
	clk,
    reset,
    
    FlushE,
    
    PCPlus4D,
    ImmExtD,
    InstrD[11:7],
    InstrD[24:20],
    InstrD[19:15],
    PCD,
    RD2D,
    RD1D,
    
    ALUSrcD,
    ALUControlD,
    BranchD,
    JumpD,
    MemWriteD,
    ResultSrcD,
    RegWriteD,
    InstrD[14:12],
    
    PCPlus4E,
    ImmExtE,
    RdE,
    Rs2E,
    Rs1E,
    PCE,
    RD2E,
    RD1E,
    
    ALUSrcE,
    ALUControlE,
    BranchE,
    JumpE,
    MemWriteE,
    ResultSrcE,
    RegWriteE,
    funct3E
	);
	
	pipelineregM prM(
	clk,
    reset,
    
    ALUResultE,
    WriteDataE,
    RdE,
    PCPlus4E,
    
    RegWriteE,
    ResultSrcE,
    MemWriteE,
    funct3E,
    
    ALUResultM,
    WriteDataM,
    RdM,
    PCPlus4M,
    
    RegWriteM,
    ResultSrcM,
    MemWriteM,
    funct3M
	);
	
	pipelineregW prW(
	clk,
    reset,

    ALUResultM,
    ReadDataM,
    RdM,
    PCPlus4M,
    
    RegWriteM,
    ResultSrcM,
    
    ALUResultW,
    ReadDataW,
    RdW,
    PCPlus4W,
    
    RegWriteW,
    ResultSrcW
	);
endmodule
