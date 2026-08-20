vlib work

vlog rtl/alu.sv
vlog rtl/register_file.sv
vlog rtl/control_unit.sv
vlog rtl/immediate_generator.sv
vlog rtl/instruction_memory.sv
vlog rtl/data_memory.sv
vlog rtl/riscv_cpu.sv
vlog rtl/riscv_system.sv
vlog tb/riscv_cpu_tb.sv

vsim -novopt work.riscv_cpu_tb

add wave -r sim:/riscv_cpu_tb/*

run 300ns

wave zoom full