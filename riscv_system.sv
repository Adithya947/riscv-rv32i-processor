module riscv_system (
    input logic        clk,
    input logic        reset,

    output logic [31:0] pc,
    output logic [31:0] instruction,
    output logic [31:0] mem_address,
    output logic [31:0] mem_write_data,
    output logic [31:0] mem_read_data
);

    logic mem_read;
    logic mem_write;

    instruction_memory imem (
        .address    (pc),
        .instruction(instruction)
    );

    data_memory dmem (
        .clk        (clk),
        .mem_read   (mem_read),
        .mem_write  (mem_write),
        .address    (mem_address),
        .write_data (mem_write_data),
        .read_data  (mem_read_data)
    );

    riscv_cpu cpu (
        .clk           (clk),
        .reset         (reset),
        .pc            (pc),
        .instruction   (instruction),
        .mem_read      (mem_read),
        .mem_write     (mem_write),
        .mem_address   (mem_address),
        .mem_write_data(mem_write_data),
        .mem_read_data (mem_read_data)
    );

endmodule