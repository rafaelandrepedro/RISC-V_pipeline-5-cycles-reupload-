module testbench;
	reg clk;
	reg reset;
	reg [2:0] pushbuttons;
	reg [3:0] switches;
	//wire [3:0] LEDs;
	top dut(
	clk,
	reset,
	pushbuttons,
    switches
);

	initial begin
		reset <= 1;
		#(5)
			;
		reset <= 0;
	end
	always begin
		clk <= 1;
		#(10)
			;
		clk <= 0;
		#(10)
			;
	end
endmodule
