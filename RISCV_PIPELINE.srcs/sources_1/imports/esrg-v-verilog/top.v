module top (
	clk,
	reset,
	pushbuttons,
    switches,
    LEDs
);
	input wire clk;
	input wire reset;
	wire rst;
	assign rst=reset;
	wire [31:0] WriteData;
	wire [31:0] DataAdr;
	wire MemWrite;
	wire [31:0] PC;
	wire [31:0] Instr;
	wire [31:0] ReadData;
	wire [2:0] LdStrType;
	
	wire [6:0] GPIOInterfaceIn;
	wire [3:0] GPIOInterfaceOut;
	input wire [2:0] pushbuttons;
	input wire [3:0] switches;
	output wire [3:0] LEDs;
	
	riscvsingle rvsingle(
		clk,
		rst,
		PC,
		Instr,
		MemWrite,
		DataAdr,
		WriteData,
		ReadData,
		LdStrType
	);
	imem imem(
		.a(PC),
		.rd(Instr)
	);
	dmem dmem(
		.clk(clk),
		.we(MemWrite),
		.a(DataAdr),
		.wd(WriteData),
		.rd(ReadData),
		.LdStrType(LdStrType),
		.reset(rst),
		.GPIOInterfaceIn(GPIOInterfaceIn),
        .GPIOInterfaceOut(GPIOInterfaceOut)
	);
	devices devices(
		.GPIOInterfaceIn(GPIOInterfaceIn),
        .GPIOInterfaceOut(GPIOInterfaceOut),
        .pushbuttons(pushbuttons),
        .switches(switches),
        .LEDs(LEDs)
	);
	
endmodule
