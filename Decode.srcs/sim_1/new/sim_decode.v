`timescale 1ns/1ps

module tb_decode;

    reg         clk;
    reg         rst;

    reg         wb_reg_write;
    reg  [4:0]  wb_write_reg_location;
    reg  [31:0] mem_wb_write_data;

 
    reg  [31:0] if_id_instr;
    reg  [31:0] if_id_npc;

  
    wire [1:0]  id_ex_wb;
    wire [2:0]  id_ex_mem;
    wire [3:0]  id_ex_execute;
    wire [31:0] id_ex_npc;
    wire [31:0] id_ex_readdat1;
    wire [31:0] id_ex_readdat2;
    wire [31:0] id_ex_sign_ext;
    wire [4:0]  id_ex_instr_bits_20_16;
    wire [4:0]  id_ex_instr_bits_15_11;


    decode dut(
        .clk                     (clk),
        .rst                     (rst),
        .wb_reg_write            (wb_reg_write),
        .wb_write_reg_location   (wb_write_reg_location),
        .mem_wb_write_data       (mem_wb_write_data),
        .if_id_instr             (if_id_instr),
        .if_id_npc               (if_id_npc),
        .id_ex_wb                (id_ex_wb),
        .id_ex_mem               (id_ex_mem),
        .id_ex_execute           (id_ex_execute),
        .id_ex_npc               (id_ex_npc),
        .id_ex_readdat1          (id_ex_readdat1),
        .id_ex_readdat2          (id_ex_readdat2),
        .id_ex_sign_ext          (id_ex_sign_ext),
        .id_ex_instr_bits_20_16  (id_ex_instr_bits_20_16),
        .id_ex_instr_bits_15_11  (id_ex_instr_bits_15_11)
    );

    
    initial clk = 0;
    always #5 clk = ~clk;      

  
    initial begin
     
        
        rst                 = 1;
        wb_reg_write        = 0;
        wb_write_reg_location = 5'd0;
        mem_wb_write_data   = 32'h0000_0000;
        if_id_instr         = 32'h0000_0000;
        if_id_npc           = 32'h0000_0000;

        
        #20;
        rst = 0;

        wb_write_reg_location = 5'd3;
        mem_wb_write_data     = 32'hAAAA_AAAA;
        wb_reg_write          = 1;
        #10;                  
        wb_reg_write          = 0;

   
        wb_write_reg_location = 5'd5;
        mem_wb_write_data     = 32'hBBBB_BBBB;
        wb_reg_write          = 1;
        #10;
        wb_reg_write          = 0;
        
        if_id_instr = 32'b100011_00011_00101_0000_0000_0000_0100;
        if_id_npc   = 32'h0040_0004;
        #10;

        if_id_instr = 32'b101011_00011_00101_0000_0000_0000_1000;
        if_id_npc   = 32'h0040_0008;
        #10;

        if_id_instr = 32'b000000_00011_00101_01001_00000_100000;
        if_id_npc   = 32'h0040_000C;
        #10;

        if_id_instr = 32'b000100_00011_00101_0000_0000_0000_0001;
        if_id_npc   = 32'h0040_0010;
        #10;

 
        #20;
        $stop;
    end

    initial begin
        $display(" time | instr            | wb mem ex | R1          R2          imm");
        $monitor("%4t | %h | %b  %b  %b | %h %h %h",
                 $time, if_id_instr,
                 id_ex_wb, id_ex_mem, id_ex_execute,
                 id_ex_readdat1, id_ex_readdat2, id_ex_sign_ext);
    end

endmodule
