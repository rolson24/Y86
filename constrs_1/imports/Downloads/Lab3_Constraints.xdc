## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
## - CASE SENSITIVE: make sure the port names here exactly match those in your top level!

### Clock signal
set_property PACKAGE_PIN W5 [get_ports {SYS_CLK}]							
	set_property IOSTANDARD LVCMOS33 [get_ports {SYS_CLK}]
#	create_clock -add -name mclk -period 20.00 -waveform {0 5} [get_ports mclk]

###Buttons
#set_property PACKAGE_PIN U18 [get_ports run_reset]						
#	set_property IOSTANDARD LVCMOS33 [get_ports run_reset]

## Switches
set_property PACKAGE_PIN R2 [get_ports {reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
## Switches
set_property PACKAGE_PIN V17 [get_ports {TTY_ready}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_ready}]
	

#Pmod Header JA
#Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {TTY_en}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_en}]
#Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {TTY_clear}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_clear}]
##Sch name = JA3
#set_property PACKAGE_PIN J2 [get_ports {mode_LA}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {mode_LA}]
##Sch name = JA4
#set_property PACKAGE_PIN G2 [get_ports {JA[3]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JA[3]}]
##Sch name = JA7
#set_property PACKAGE_PIN H1 [get_ports {JA[4]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JA[4]}]
##Sch name = JA8
#set_property PACKAGE_PIN K2 [get_ports {JA[5]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JA[5]}]
##Sch name = JA9
#set_property PACKAGE_PIN H2 [get_ports {JA[6]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JA[6]}]
##Sch name = JA10
#set_property PACKAGE_PIN G3 [get_ports {JA[7]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JA[7]}]

#Pmod Header JC
#Sch name = JC1
set_property PACKAGE_PIN K17 [get_ports {TTY_data[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_data[3]}]
#Sch name = JC2
set_property PACKAGE_PIN M18 [get_ports {TTY_data[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_data[4]}]
#Sch name = JC3
set_property PACKAGE_PIN N17 [get_ports {TTY_data[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_data[5]}]
#Sch name = JC4
set_property PACKAGE_PIN P18 [get_ports {TTY_data[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_data[6]}]
##Sch name = JC7
#set_property PACKAGE_PIN L17 [get_ports {JC[4]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {JC[4]}]
#Sch name = JC8
set_property PACKAGE_PIN M19 [get_ports {TTY_data[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_data[0]}]
#Sch name = JC9
set_property PACKAGE_PIN P17 [get_ports {TTY_data[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_data[1]}]
#Sch name = JC10
set_property PACKAGE_PIN R18 [get_ports {TTY_data[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {TTY_data[2]}]

#USB HID (PS/2)
set_property PACKAGE_PIN C17 [get_ports ps2_clk]						
	set_property IOSTANDARD LVCMOS33 [get_ports ps2_clk]
	set_property PULLUP true [get_ports ps2_clk]
set_property PACKAGE_PIN B17 [get_ports ps2_in]					
	set_property IOSTANDARD LVCMOS33 [get_ports ps2_in]	
	set_property PULLUP true [get_ports ps2_in]

## These additional constraints are recommended by Digilent, do not remove!
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]