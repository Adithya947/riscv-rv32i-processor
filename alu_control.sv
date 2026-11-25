module alu_control (
    input  logic [1:0] ALUOp,
    input  logic [2:0] funct3,
    input  logic       funct7_5,      // bit 30 of the instruction
    input  logic       is_rtype,      // 1 if opcode is 0110011
    output logic [2:0] ALUControl
);
    always_comb begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000;                 // lw, sw: add
            2'b01: ALUControl = 3'b001;                 // beq: subtract
            2'b10: begin
                case (funct3)
                    3'b000:  ALUControl = (is_rtype && funct7_5) ? 3'b001 : 3'b000; // sub or add
                    3'b111:  ALUControl = 3'b010;       // and
                    3'b110:  ALUControl = 3'b011;       // or
                    default: ALUControl = 3'b000;
                endcase
            end
            default: ALUControl = 3'b000;
        endcase
    end
endmodule
