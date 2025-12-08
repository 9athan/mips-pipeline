`timescale 1ns/1ps

module writebackTB;

    reg  [1:0]  wb_ctrl;
    reg  [31:0] read_data;
    reg  [31:0] alu_result;
    reg  [4:0]  write_reg;

    wire        wb_reg_write;
    wire [4:0]  wb_write_reg_location;
    wire [31:0] wb_write_data;

    writeback_stage uut (
        .mem_wb_wb           (wb_ctrl),
        .mem_wb_read_data    (read_data),
        .mem_wb_alu_result   (alu_result),
        .mem_wb_write_reg    (write_reg),
        .wb_reg_write        (wb_reg_write),
        .wb_write_reg_location(wb_write_reg_location),
        .mem_wb_write_data   (wb_write_data)
    );

    initial begin
        // Test ALUResult path (MemToReg = 0)
        wb_ctrl    = 2'b10;           // RegWrite=1, MemToReg=0
        read_data  = 32'hAAAA_BBBB;
        alu_result = 32'h1111_2222;
        write_reg  = 5'd8;
        #10;

        // Test ReadData path (MemToReg = 1)
        wb_ctrl    = 2'b11;           // RegWrite=1, MemToReg=1
        read_data  = 32'hDEAD_BEEF;
        alu_result = 32'h3333_4444;
        write_reg  = 5'd9;
        #10;

        $finish;
    end

endmodule
