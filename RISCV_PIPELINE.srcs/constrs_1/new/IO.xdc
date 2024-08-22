set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
set_property PACKAGE_PIN K17 [get_ports clk]

create_clock -period 50000.000 -name clk -waveform {0.000 25000.000} [get_ports clk]



create_interface interface_1

set_property PACKAGE_PIN Y16 [get_ports reset]

set_property PACKAGE_PIN V16 [get_ports {pushbuttons[2]}]
set_property PACKAGE_PIN P16 [get_ports {pushbuttons[1]}]
set_property PACKAGE_PIN R18 [get_ports {pushbuttons[0]}]
set_property PACKAGE_PIN D18 [get_ports {LEDs[3]}]
set_property PACKAGE_PIN G14 [get_ports {LEDs[2]}]
set_property PACKAGE_PIN M15 [get_ports {LEDs[1]}]
set_property PACKAGE_PIN M14 [get_ports {LEDs[0]}]
set_property PACKAGE_PIN T16 [get_ports {switches[3]}]
set_property PACKAGE_PIN W13 [get_ports {switches[2]}]
set_property PACKAGE_PIN P15 [get_ports {switches[1]}]
set_property PACKAGE_PIN G15 [get_ports {switches[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LEDs[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pushbuttons[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pushbuttons[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {pushbuttons[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {switches[0]}]
