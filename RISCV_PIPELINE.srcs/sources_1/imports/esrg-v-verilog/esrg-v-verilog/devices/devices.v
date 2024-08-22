module devices(
    GPIOInterfaceIn,
    GPIOInterfaceOut,
    pushbuttons,
    switches,
    LEDs
    );
    output wire [6:0] GPIOInterfaceIn;
    input wire [3:0] GPIOInterfaceOut;
    input wire [2:0] pushbuttons;
    input wire [3:0] switches;
    output wire [3:0] LEDs;
    
    assign GPIOInterfaceIn={pushbuttons,switches};
    assign LEDs=GPIOInterfaceOut;
endmodule
