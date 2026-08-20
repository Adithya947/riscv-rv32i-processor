module riscv_cpu (
    input  logic        clk,
    input  logic        reset,

    output logic [31:0] pc,
    input  logic [31:0] instruction,

    output logic        mem_read,
    output logic        mem_write,
    output logic [31:0] mem_address,
    output logic [31:0] mem_write_data,
    input  logic [31:0] mem_read_data
);

    logic [31:0] next_pc;

    logic [4:0] rs1, rs2, rd;
    logic [31:0] read_data1, read_data2;
    logic [31:0] write_data;

    logic        reg_write;
    logic        branch;
    logic        alu_src;
    logic [2:0]  alu_control;

    logic [31:0] alu_input2;
    logic [31:0] alu_result;
    logic        alu_zero;

    logic [31:0] immediate;

    // Instruction fields
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    assign rd  = instruction[11:7];

    // Immediate for LW/SW
    immediate_generator imm_gen (
    .instruction(instruction),
    .immediate(immediate)
);

    control_unit control (
        .opcode       (instruction[6:0]),
        .funct3       (instruction[14:12]),
        .funct7       (instruction[31:25]),
        .reg_write    (reg_write),
        .mem_read     (mem_read),
        .mem_write    (mem_write),
        .branch       (branch),
        .alu_src      (alu_src),
        .alu_control  (alu_control)
    );

    register_file registers (
        .clk          (clk),
        .reset        (reset),
        .rs1          (rs1),
        .rs2          (rs2),
        .rd           (rd),
        .write_data   (write_data),
        .reg_write    (reg_write),
        .read_data1   (read_data1),
        .read_data2   (read_data2)
    );

    assign alu_input2 = alu_src ? immediate : read_data2;

    alu alu_unit (
        .a            (read_data1),
        .b            (alu_input2),
        .alu_control  (alu_control),
        .result       (alu_result),
        .zero         (alu_zero)
    );

    assign mem_address    = alu_result;
    assign mem_write_data = read_data2;

    // Write back either ALU result or loaded memory data
    always_comb begin
        if (mem_read)
            write_data = mem_read_data;
        else
            write_data = alu_result;
    end

    // Program counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'b0;
        else
            pc <= next_pc;
    end

    // Next PC
    always_comb begin
        next_pc = pc + 32'd4;

        if (branch && alu_zero)
            next_pc = pc + immediate;
    end

endmodule