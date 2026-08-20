module register_file (
    input  logic        clk,
    input  logic        reset,

    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,

    input  logic [31:0] write_data,
    input  logic        reg_write,

    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

    // 32 registers, each 32 bits wide
    logic [31:0] registers [0:31];

    integer i;

    // ---------------------------------------------------------
    // Register write
    // ---------------------------------------------------------

    always_ff @(posedge clk or posedge reset) begin

        if (reset) begin

            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'd0;

        end
        else begin

            // x0 is hardwired to zero
            if (reg_write && (rd != 5'd0))
                registers[rd] <= write_data;

            registers[0] <= 32'd0;

        end

    end

    // ---------------------------------------------------------
    // Register reads
    // ---------------------------------------------------------

    always_comb begin

        if (rs1 == 5'd0)
            read_data1 = 32'd0;
        else
            read_data1 = registers[rs1];

        if (rs2 == 5'd0)
            read_data2 = 32'd0;
        else
            read_data2 = registers[rs2];

    end

endmodule