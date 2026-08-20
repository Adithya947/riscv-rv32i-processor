# RISC-V (RV32I) Processor Design

A basic RISC-V RV32I processor designed and simulated using SystemVerilog.

## Project Description

This project implements a simple RISC-V processor capable of executing a small set of RV32I instructions. The processor contains the main components required for instruction execution, including an ALU, register file, control unit, immediate generator, instruction memory, data memory, and program counter logic.

## Supported Instructions

- ADD
- SUB
- LW
- SW
- BEQ

## Main Components

- **ALU** – Performs arithmetic and logical operations.
- **Register File** – Provides 32 general-purpose 32-bit registers.
- **Control Unit** – Generates control signals based on the instruction.
- **Immediate Generator** – Generates immediates for I-type, S-type, B-type, and J-type instructions.
- **Instruction Memory** – Stores the test instructions executed by the processor.
- **Data Memory** – Provides memory read/write functionality.
- **RISC-V CPU** – Connects the datapath and control logic.
- **RISC-V System** – Connects the CPU with instruction and data memory.
- **Testbench** – Generates the clock, reset, initializes registers, and runs the processor simulation.

## Project Structure

```text
riscv-rv32i-processor/
│
├── rtl/
│   ├── alu.sv
│   ├── register_file.sv
│   ├── control_unit.sv
│   ├── immediate_generator.sv
│   ├── instruction_memory.sv
│   ├── data_memory.sv
│   ├── riscv_cpu.sv
│   └── riscv_system.sv
│
├── tb/
│   └── riscv_cpu_tb.sv
│
├── screenshots/
│   └── waveform.png
│
└── riscv_run.do
