module regfile (
    input  logic        clk,
    input  logic        reset,

    input  logic        we,
    input  logic [4:0]  rs1, rs2, rd,
    input  logic [31:0] wd,

    output logic [31:0] rd1, rd2
);
    // 32 registers, each 32 bits wide
    logic [31:0] regs [0:31];

    // ---------- clocked write, with asynchronous reset ----------
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 32; i++)
                regs[i] <= 32'd0;
        end
        else begin
            if (we && (rd != 5'd0))        // x0 is hardwired to zero
                regs[rd] <= wd;
        end
    end

    // ---------- combinational reads, x0 always reads 0 ----------
    always_comb begin
        rd1 = (rs1 == 5'd0) ? 32'd0 : regs[rs1];
        rd2 = (rs2 == 5'd0) ? 32'd0 : regs[rs2];
    end
endmodule
