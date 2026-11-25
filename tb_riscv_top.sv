module tb;
    reg clk = 0, reset = 1;

    riscv_top dut (.clk(clk), .reset(reset));

    always #5 clk = ~clk;            // clock period = 10 time units

    initial begin
        #12 reset = 0;               // release reset after the first edge
        #300;                         // let the program run
        $display("x1=%0d x2=%0d x3=%0d x4=%0d x5=%0d x6=%0d x7=%0d x8=%0d x9=%0d",
             dut.u_rf.regs[1], dut.u_rf.regs[2], dut.u_rf.regs[3], dut.u_rf.regs[4],
             dut.u_rf.regs[5], dut.u_rf.regs[6], dut.u_rf.regs[7],
             $signed(dut.u_rf.regs[8]), dut.u_rf.regs[9]);
    $finish;
end

endmodule
