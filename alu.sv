module alu (
    input  logic [31:0] A, B,
    input  logic [2:0]  ALUControl,
    output logic [31:0] result,
    output logic        Zero
);
    always_comb begin
        case (ALUControl)
            3'b000:  result = A + B;     // add
            3'b001:  result = A - B;     // subtract
            3'b010:  result = A & B;     // and
            3'b011:  result = A | B;     // or
            default: result = 32'b0;
        endcase
    end

    always_comb Zero = (result == 32'b0);
endmodule
