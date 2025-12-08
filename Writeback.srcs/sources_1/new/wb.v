// writeback_stage.v

module writeback_stage (
    input  [1:0]  mem_wb_wb,
    input  [31:0] mem_wb_read_data,
    input  [31:0] mem_wb_alu_result,
    input  [4:0]  mem_wb_write_reg,

    output        wb_reg_write,
    output [4:0]  wb_write_reg_location,
    output [31:0] mem_wb_write_data
);
    // mem_wb_wb[1] = RegWrite
    // mem_wb_wb[0] = MemToReg
    wire MemToReg = mem_wb_wb[0];

    assign wb_reg_write          = mem_wb_wb[1];
    assign wb_write_reg_location = mem_wb_write_reg;

    mux2 #(.WIDTH(32)) memtoreg_mux (
        .a_true (mem_wb_read_data),   // selected when MemToReg = 1
        .b_false(mem_wb_alu_result),  // selected when MemToReg = 0
        .sel    (MemToReg),
        .y      (mem_wb_write_data)
    );

endmodule
