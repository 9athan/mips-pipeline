`timescale 1ns / 1ps
// mem_wb.v  --  MEM/WB pipeline register

module MEM_WB (
    input         clk,
    input  [1:0]  WBControl_in,     // {RegWrite, MemToReg}
    input  [31:0] ReadData_in,
    input  [31:0] ALUResult_in,
    input  [4:0]  WriteReg_in,

    output reg [1:0]  WBControl_out,
    output reg [31:0] ReadData_out,
    output reg [31:0] ALUResult_out,
    output reg [4:0]  WriteReg_out
);

    always @(posedge clk) begin
        WBControl_out  <= WBControl_in;
        ReadData_out   <= ReadData_in;
        ALUResult_out  <= ALUResult_in;
        WriteReg_out   <= WriteReg_in;
    end

endmodule

