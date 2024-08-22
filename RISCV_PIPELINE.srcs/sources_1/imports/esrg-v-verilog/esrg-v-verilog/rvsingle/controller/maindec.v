module maindec (
	op,
	ResultSrc,
	MemWrite,
	Branch,
	ALUSrc,
	RegWrite,
	Jump,
	ImmSrc,
	ALUOp
);
	input wire [6:0] op;
	output wire [2:0] ResultSrc;
	output wire MemWrite;
	output wire Branch;
	output wire ALUSrc;
	output wire RegWrite;
	output wire [1:0] Jump;
	output wire [2:0] ImmSrc;
	output wire [1:0] ALUOp;
	reg [13:0] controls;
	//          1        3       1       1         3          1     2      2
	assign {RegWrite, ImmSrc, ALUSrc, MemWrite, ResultSrc, Branch, ALUOp, Jump} = controls;
	always @(*)
		case (op)
			7'b0000011: controls = 14'b1_000_1_0_001_0_00_00;
			7'b0100011: controls = 14'b0_001_1_1_000_0_00_00;
			7'b0110011: controls = 14'b1_xxx_0_0_000_0_10_00;
			7'b1100011: controls = 14'b0_010_0_0_000_1_01_00;
			7'b1100111: controls = 14'b1_100_0_0_010_0_00_11; //jalr
			7'b0010011: controls = 14'b1_000_1_0_000_0_10_00;
			7'b1101111: controls = 14'b1_011_0_0_010_0_00_01;
			7'b0110111: controls = 14'b1_101_1_0_011_0_00_00; //lui(gi)
			7'b0010111: controls = 14'b1_101_1_0_100_0_00_00; //auipc
			default: controls = 14'b0_000_0_0_000_0_00_00;
		endcase
endmodule
