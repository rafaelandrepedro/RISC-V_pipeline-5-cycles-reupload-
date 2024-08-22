module regfile (
	clk,
	we3,
	a1,
	a2,
	a3,
	wd3,
	rd1,
	rd2,
	ResultSrc,
	LdStrType
);
	input wire clk;
	input wire we3;
	input wire [4:0] a1;
	input wire [4:0] a2;
	input wire [4:0] a3;
	input wire [31:0] wd3;
	input wire [2:0] ResultSrc;
	input wire [2:0] LdStrType;
	output wire [31:0] rd1;
	output wire [31:0] rd2;
	reg [31:0] rf [31:0];
	always @(posedge clk)
		if (we3)
		  if(ResultSrc==3'b001) begin
              case(LdStrType)
                3'b000: rf[a3] <= {24'b0,wd3[7:0]};
                3'b001: rf[a3] <= {16'b0,wd3[15:0]};
                3'b010: rf[a3] <= wd3[31:0];
                3'b100: rf[a3] <= {rf[a3][31:8],wd3[7:0]};
                3'b101: rf[a3] <= {rf[a3][31:16],wd3[15:0]};
                default: rf[a3] <= 32'b0;
              endcase
          end else begin	
            rf[a3]=wd3;
		  end
		  
	assign rd1 = a1 == a3 ? wd3 : (a1 != 0 ? rf[a1] : 0);
	assign rd2 = a2 == a3 ? wd3 : (a2 != 0 ? rf[a2] : 0);
endmodule
