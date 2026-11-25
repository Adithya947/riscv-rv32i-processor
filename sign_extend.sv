module sign_extend (
    input  logic [31:0] instr,
    output logic [31:0] imm_ext
);
    always_comb begin
        case (instr[6:0])                        // opcode picks the layout

            // I-type: addi, andi, ori, lw
            7'b0010011,
            7'b0000011: imm_ext = {{20{instr[31]}}, instr[31:20]};

            // S-type: sw
            7'b0100011: imm_ext = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            // B-type: beq
            7'b1100011: imm_ext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};

            // J-type: jal (not used yet, kept for later)
            7'b1101111: imm_ext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

            default:    imm_ext = 32'd0;

        endcase
    end
endmodule
