`timescale 1ns / 1ps
// dmem.v  --  Data Memory (256 x 32)
// Word-addressed using address[9:2]

module D_MEM (
    input         clk,
    input         MemWrite,
    input         MemRead,
    input  [31:0] Address,
    input  [31:0] WriteData,
    output [31:0] ReadData
);

    reg [31:0] MEM [0:255];

    // Initialize from data.mem (Lab 6 / assignment)
    initial begin
        $readmemb("data.mem", MEM);
    end

    // synchronous write
    always @(posedge clk) begin
        if (MemWrite)
            MEM[Address[9:2]] <= WriteData;
    end

    // asynchronous read (gated by MemRead)
    assign ReadData = MemRead ? MEM[Address[9:2]] : 32'b0;

endmodule

