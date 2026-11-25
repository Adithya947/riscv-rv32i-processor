module sign_extend (
    input  logic [31:0] instr,
    output logic [31:0] imm_ext
);
    always_comb begin
        case (instr[6:0])                                    // opcode picks the layout
            7'b0100011: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};                       // S-type (sw)
            7'b1100011: imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};       // B-type (beq)
            default:    imm_ext = {{20{instr[31]}}, instr[31:20]};                                    // I-type (addi, lw)
        endcase
    end
endmodule
