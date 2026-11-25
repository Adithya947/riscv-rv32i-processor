module imem (
    input  logic [31:0] pc,
    output logic [31:0] instr
);
    logic [31:0] mem [0:255];                    // 256 words

    // initial $readmemh("program.hex", mem);    // use on a PC with a hex file

    initial begin
        mem[0] = 32'h00700293;   // addr 0  : addi x5, x0, 7
        mem[1] = 32'h00500313;   // addr 4  : addi x6, x0, 5
        mem[2] = 32'h006283B3;   // addr 8  : add  x7, x5, x6
        mem[3] = 32'h00702023;   // addr 12 : sw   x7, 0(x0)
        mem[4] = 32'h00002403;   // addr 16 : lw   x8, 0(x0)
        mem[5] = 32'h00740463;   // addr 20 : beq  x8, x7, +8
        mem[6] = 32'h06300493;   // addr 24 : addi x9, x0, 99 (skipped)
        mem[7] = 32'h00100513;   // addr 28 : addi x10, x0, 1
    end

    always_comb instr = mem[pc[9:2]];            // combinational read
endmodule
