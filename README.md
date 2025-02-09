# Y86
This is a CPU based on a simplified version of x86 architecture. It is written in Verilog and designed in Xilinx Vivado 2018.3.1
Only the source verilog, and memory coefficients files for memory blocks are in this repository.
The design sources are in "design_sources" and the simulation sources are in "simulation_sources".
The coefficients files for initializing the ROM blocks are in "ROM_coeff_files".

If you want to reproduce this project, first clone this repository. Then create a new RTL project in Xilinx Vivado and add the design sources and simulation sources from this repository.
Then use Vivado's Block Memory Generator to create the following ROM's:

1. "FSM_control_ROM" is a "Single Port ROM" with a 32 bit read width and a read depth of 64. Set the block to "Always enabled" and load the init file from "Y86/ROM_coeff_files/FSM_micro_instructions.coe"

2. "FSM_next_states" is a "Single Port ROM" with a 12 bit read width and a read depth of 64. Set the block to "Always enabled" and load the init file from "Y86/ROM_coeff_files/FSM_next_states.coe"

3. "I_ROM" is a "Single Port ROM" with a 10 bit read width and a read depth of 1024. Set the block to "Always enabled" and load the init file from "Y86/ROM_coeff_files/instructions.coe"

4. "Data_RAM" is a "Single Port RAM" with a 8 bit read and write width and a read and write depth of 1024. Set the block to "Always enabled" and "write first" and initialize the values to 0.

