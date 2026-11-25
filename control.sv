module control (
    input  logic [6:0] opcode,
    output logic       RegWrite, ALUSrc, MemWrite, MemToReg, Branch,
    output logic [1:0] ALUOp
);
    always_comb begin
        case (opcode)
            //                     RegW ALUSrc MemW MemToReg Branch ALUOp
            7'b0110011: {RegWrite, ALUSrc, MemWrite, MemToReg, Branch, ALUOp} = 7'b1_0_0_0_0_10; // reg-reg ALU
            7'b0010011: {RegWrite, ALUSrc, MemWrite, MemToReg, Branch, ALUOp} = 7'b1_1_0_0_0_10; // reg-const ALU
            7'b0000011: {RegWrite, ALUSrc, MemWrite, MemToReg, Branch, ALUOp} = 7'b1_1_0_1_0_00; // load
            7'b0100011: {RegWrite, ALUSrc, MemWrite, MemToReg, Branch, ALUOp} = 7'b0_1_1_0_0_00; // store
            7'b1100011: {RegWrite, ALUSrc, MemWrite, MemToReg, Branch, ALUOp} = 7'b0_0_0_0_1_01; // branch
            default:    {RegWrite, ALUSrc, MemWrite, MemToReg, Branch, ALUOp} = 7'b0_0_0_0_0_00;
        endcase
    end
endmodule
