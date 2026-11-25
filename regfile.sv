module regfile (
    input  logic        clk, we,
    input  logic [4:0]  rs1, rs2, rd,
    input  logic [31:0] wd,
    output logic [31:0] rd1, rd2
);
    logic [31:0] regs [0:31];

    initial for (int i = 0; i < 32; i++) regs[i] = 32'b0;   // simulation only

    always_comb rd1 = (rs1 == 5'd0) ? 32'b0 : regs[rs1];    // combinational read, x0 reads as 0
    always_comb rd2 = (rs2 == 5'd0) ? 32'b0 : regs[rs2];

    always_ff @(posedge clk)
        if (we && rd != 5'd0)                               // clocked write, never write x0
            regs[rd] <= wd;
endmodule
