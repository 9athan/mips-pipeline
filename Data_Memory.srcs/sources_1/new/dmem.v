`timescale 1ns / 1ps

module D_MEM (
    input         clk,
    input         MemWrite,
    input         MemRead,
    input  [31:0] Address,
    input  [31:0] WriteData,
    output [31:0] ReadData
);

    reg [31:0] MEM [0:255];


    initial begin
        $readmemb("data.mem", MEM);
    end

    always @(posedge clk) begin
        if (MemWrite)
            MEM[Address[9:2]] <= WriteData;
    end

    assign ReadData = MemRead ? MEM[Address[9:2]] : 32'b0;

endmodule

