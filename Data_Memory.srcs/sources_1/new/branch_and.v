`timescale 1ns / 1ps

// branch_and.v  --  AND gate for PCSrc = Branch & Zero

module BRANCH_AND (
    input  Branch,
    input  Zero,
    output PCSrc
);

    assign PCSrc = Branch & Zero;

endmodule
