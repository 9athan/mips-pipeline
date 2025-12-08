`timescale 1ns / 1ps

// imem.v  --  Instruction memory (128 x 32)

module I_MEM (
    input  [31:0] Address,
    output [31:0] Instr
);

    reg [31:0] MEM [0:127];

    initial begin
        // Use the instr.mem file given in the assignment
        $readmemb("instr.mem", MEM);
    end

    // Word addressed: PC[31:2]
    assign Instr = MEM[Address[31:2]];

endmodule
