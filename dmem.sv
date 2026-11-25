module dmem (
    input  logic        clk, MemWrite,
    input  logic [31:0] addr, write_data,
    output logic [31:0] read_data
);
    logic [31:0] mem [0:255];

    initial for (int i = 0; i < 256; i++) mem[i] = 32'b0;

    always_comb read_data = mem[addr[9:2]];                 // combinational read

    always_ff @(posedge clk)
        if (MemWrite) mem[addr[9:2]] <= write_data;         // clocked write
endmodule
