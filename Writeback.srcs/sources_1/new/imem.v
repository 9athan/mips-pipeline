`timescale 1ns / 1ps

module I_MEM (
    input  [31:0] Address,
    output [31:0] Instr
);

    reg [31:0] MEM [0:127];

    initial begin
        $readmemb("instr.mem", MEM);
    end

    assign Instr = MEM[Address[31:2]];

endmodule

