`timescale 1ns/1ps

module riscv_cpu_tb;

    logic clk;
    logic reset;

    logic [31:0] pc;
    logic [31:0] instruction;
    logic [31:0] mem_address;
    logic [31:0] mem_write_data;
    logic [31:0] mem_read_data;

    riscv_system dut (
        .clk           (clk),
        .reset         (reset),
        .pc            (pc),
        .instruction   (instruction),
        .mem_address   (mem_address),
        .mem_write_data(mem_write_data),
        .mem_read_data (mem_read_data)
    );

    // Clock
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1'b1;

#10;

// Initialize registers
dut.cpu.registers.registers[1] = 32'd10;  // x1 = 10
dut.cpu.registers.registers[2] = 32'd5;   // x2 = 5

#10;
reset = 1'b0;

        #200;

        $finish;
    end

    // Display processor activity
    always @(posedge clk) begin
        $display(
            "Time=%0t PC=%h Instruction=%h MemAddr=%h WriteData=%h",
            $time,
            pc,
            instruction,
            mem_address,
            mem_write_data
        );
    end

endmodule