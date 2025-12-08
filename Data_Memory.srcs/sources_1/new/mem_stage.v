`timescale 1ns / 1ps

module mem_stage (
    input         clk,
    input  [31:0] ALUResult,
    input  [31:0] WriteData,
    input  [4:0]  WriteReg,
    input  [1:0]  WBControl,
    input         MemWrite,
    input         MemRead,
    input         Branch,
    input         Zero,

    output [31:0] ReadData,
    output [31:0] ALUResult_out,
    output [4:0]  WriteReg_out,
    output [1:0]  WBControl_out,
    output        PCSrc
);

    wire [31:0] mem_read_data;

    BRANCH_AND u_and (
        .Branch(Branch),
        .Zero(Zero),
        .PCSrc(PCSrc)
    );

    D_MEM u_dmem (
        .clk       (clk),
        .MemWrite  (MemWrite),
        .MemRead   (MemRead),
        .Address   (ALUResult),
        .WriteData (WriteData),
        .ReadData  (mem_read_data)
    );

    MEM_WB u_memwb (
        .clk          (clk),
        .WBControl_in (WBControl),
        .ReadData_in  (mem_read_data),
        .ALUResult_in (ALUResult),
        .WriteReg_in  (WriteReg),

        .WBControl_out(WBControl_out),
        .ReadData_out (ReadData),
        .ALUResult_out(ALUResult_out),
        .WriteReg_out (WriteReg_out)
    );

endmodule

