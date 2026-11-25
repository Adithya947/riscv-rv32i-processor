module riscv_top (
    input logic clk,
    input logic reset
);
    // ---------- wires ----------
    logic [31:0] pc, next_pc, pc_plus4, pc_branch;
    logic [31:0] instr;
    logic [31:0] rd1, rd2, imm_ext, B, result, read_data, wd;
    logic        RegWrite, ALUSrc, MemWrite, MemToReg, Branch, Zero, PCSrc, is_rtype;
    logic [1:0]  ALUOp;
    logic [2:0]  ALUControl;

    // ---------- PC and next-PC logic ----------
    pc_reg u_pc (.clk(clk), .reset(reset), .next_pc(next_pc), .pc(pc));
    assign pc_plus4  = pc + 32'd4;
    assign pc_branch = pc + imm_ext;
    assign PCSrc     = Branch & Zero;
    assign next_pc   = PCSrc ? pc_branch : pc_plus4;

    // ---------- fetch ----------
    imem u_imem (.pc(pc), .instr(instr));

    // ---------- control ----------
    control u_ctrl (.opcode(instr[6:0]), .RegWrite(RegWrite), .ALUSrc(ALUSrc),
                    .MemWrite(MemWrite), .MemToReg(MemToReg), .Branch(Branch), .ALUOp(ALUOp));
    assign is_rtype = (instr[6:0] == 7'b0110011);
    alu_control u_aluctrl (.ALUOp(ALUOp), .funct3(instr[14:12]), .funct7_5(instr[30]),
                           .is_rtype(is_rtype), .ALUControl(ALUControl));

    // ---------- register file, immediate, ALU ----------
    regfile u_rf (.clk(clk), .reset(reset), .we(RegWrite),
                  .rs1(instr[19:15]), .rs2(instr[24:20]), .rd(instr[11:7]),
                  .wd(wd), .rd1(rd1), .rd2(rd2));
    sign_extend u_imm (.instr(instr), .imm_ext(imm_ext));
    assign B = ALUSrc ? imm_ext : rd2;
    alu u_alu (.A(rd1), .B(B), .ALUControl(ALUControl), .result(result), .Zero(Zero));

    // ---------- data memory and write-back ----------
    dmem u_dmem (.clk(clk), .MemWrite(MemWrite), .addr(result),
                 .write_data(rd2), .read_data(read_data));
    assign wd = MemToReg ? read_data : result;
endmodule
