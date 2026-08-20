module control_unit (
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,

    output logic       reg_write,
    output logic       mem_read,
    output logic       mem_write,
    output logic       branch,
    output logic       alu_src,
    output logic [2:0] alu_control
);

    always_comb begin
        // Defaults
        reg_write  = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        branch     = 1'b0;
        alu_src    = 1'b0;
        alu_control = 3'b000;

        case (opcode)

            // R-type: ADD / SUB
            7'b0110011: begin
                reg_write = 1'b1;

                if (funct3 == 3'b000 && funct7 == 7'b0100000)
                    alu_control = 3'b001; // SUB
                else
                    alu_control = 3'b000; // ADD
            end

            // LW
            7'b0000011: begin
                reg_write   = 1'b1;
                mem_read    = 1'b1;
                alu_src     = 1'b1;
                alu_control = 3'b000;
            end

            // SW
            7'b0100011: begin
                mem_write   = 1'b1;
                alu_src     = 1'b1;
                alu_control = 3'b000;
            end

            // BEQ
            7'b1100011: begin
                branch      = 1'b1;
                alu_control = 3'b001;
            end

            default: begin
                // Keep defaults
            end

        endcase
    end

endmodule