module dmem (
	clk,
	we,
	a,
	wd,
	rd,
	LdStrType,
	reset,
	GPIOInterfaceIn,
    GPIOInterfaceOut
);
	input wire clk;
	input wire reset;
	input wire we;
	input wire [31:0] a;
	input wire [31:0] wd;
	input wire [2:0] LdStrType;
	
	input wire [6:0] GPIOInterfaceIn;
	output wire [3:0] GPIOInterfaceOut;
	
	output wire [31:0] rd;
	reg [31:0] RAM [63:0];
	
	assign rd = a[31:2] ? RAM[a[31:2]] : {21'b000000000000000000000, RAM[a[31:2]][10:0]};
	
	assign GPIOInterfaceOut=RAM[0][3:0];
	
	always @(posedge clk) begin
		if (we) begin
            if(a[31:2]>=1) begin //data memory
                case(LdStrType)
                  3'b000: RAM[a[31:2]] <= {24'b0,wd[7:0]};
                  3'b001: RAM[a[31:2]] <= {16'b0,wd[15:0]};
                  3'b010: RAM[a[31:2]] <= wd[31:0];
                  3'b100: RAM[a[31:2]] <= {RAM[a[31:2]][31:8],wd[7:0]};
                  3'b101: RAM[a[31:2]] <= {RAM[a[31:2]][31:16],wd[15:0]};
                  default: RAM[a[31:2]] <= 32'b0;
                endcase
            end else if(a[31:2]==0) begin //GPIO Pheripheral
                //[31:16]-reserved (future use) read only
                //[15:5]-input peripherals (pushbuttons+switches) read only
                //[4:0]-output peripherals (LEDs) read+write
                RAM[a[31:2]][3:0] <= wd[3:0]; 
            end
        end
        RAM[0][10:4]=GPIOInterfaceIn;
    end
    always @(*)
        RAM[0][3:0]=5;
endmodule
