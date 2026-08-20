module instruction_memory (
    input  logic [31:0] address,
    output logic [31:0] instruction
);

    logic [31:0] memory [0:31];

    initial begin
        // ADD x3, x1, x2
        memory[0] = 32'h002081B3;

        // SUB x4, x3, x1
        memory[1] = 32'h40118233;

        // SW x4, 0(x0)
        memory[2] = 32'h00402023;

        // LW x5, 0(x0)
        memory[3] = 32'h00002283;

        // BEQ x4, x5, +8
        memory[4] = 32'h00520463;

        // ADD x6, x0, x0
        memory[5] = 32'h00000333;

        // ADD x7, x1, x2
        memory[6] = 32'h002083B3;
    end

    always_comb begin
        instruction = memory[address[6:2]];
    end

endmodule