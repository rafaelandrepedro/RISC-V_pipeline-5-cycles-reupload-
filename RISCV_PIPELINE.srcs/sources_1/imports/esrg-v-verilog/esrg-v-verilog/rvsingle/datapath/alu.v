module alu (
	SrcA,
	SrcB,
	ALUControl,
	ALUResult,
	Zero,
	Carry,
	Verflow,
	Negative
);

    input wire signed [31:0] SrcA;
    input wire signed [31:0] SrcB;
    wire [31:0] SrcA_u;
    wire [31:0] SrcB_u;
	input wire [3:0] ALUControl;
	output reg [31:0] ALUResult;
	output wire Zero;
	output wire Carry;
	output wire Verflow;
	output wire Negative;
	
	wire Cout;
	wire [31:0] Sum;
	
	assign {Cout,Sum} = ALUControl[0] ? (SrcA_u - SrcB_u) : (SrcA_u + SrcB_u);
	
	assign Verflow = ~(SrcB_u[31] ^ SrcA_u[31] ^ ALUControl[0]) & (SrcA_u[31] ^ Sum[31]) & ALUControl[1];
	assign Carry = ~ALUControl[1] & Cout;
	assign Negative = ALUResult[31];
	assign Zero = ALUResult == 32'b00000000000000000000000000000000;
	
	assign SrcA_u = SrcA;
    assign SrcB_u = SrcB;
    always @(*)
        case (ALUControl)
            4'b0000: ALUResult = SrcA + SrcB;
            4'b0001: ALUResult = SrcA - SrcB;
            4'b0010: ALUResult = SrcA & SrcB;
            4'b0011: ALUResult = SrcA | SrcB;
            4'b0100: ALUResult = SrcA ^ SrcB;
            4'b0101: ALUResult = SrcA < SrcB;
            4'b0110: ALUResult = SrcA << SrcB;
            4'b0111: ALUResult = SrcA >> SrcB;
            4'b1000: ALUResult = SrcA >>> SrcB;
            4'b1001: ALUResult = SrcA_u < SrcB_u;
            default: ALUResult = ALUResult;
        endcase
endmodule 