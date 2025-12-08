`timescale 1ns/1ps

module tb_fetch;
    reg         clk;
    reg         rst;
    reg         ex_mem_pc_src;
    reg  [31:0] ex_mem_npc;
    wire [31:0] if_id_instr; 
    wire [31:0] if_id_npc;

    // DUT
    fetch dut (
        .clk           (clk),
        .rst           (rst),
        .ex_mem_pc_src (ex_mem_pc_src),
        .ex_mem_npc    (ex_mem_npc),
        .if_id_instr   (if_id_instr),
        .if_id_npc     (if_id_npc)
    );

    // clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // stimulus
    initial begin
        // waveform dump (for GTKWave)
        $dumpfile("fetch.vcd");
        $dumpvars(0, tb_fetch);

        // init
        rst = 1;
        ex_mem_pc_src = 0;
        ex_mem_npc    = 32'h0000_0004; // 32 decimal (word index 8)

        // release reset
        #12; rst = 0;

        // run sequential a few cycles
        repeat (6) @(posedge clk);

        // take a branch for one cycle
        @(posedge clk);
        ex_mem_pc_src <= 1;
        @(posedge clk);
        ex_mem_pc_src <= 0;

        // run more cycles
        repeat (8) @(posedge clk);

        $finish;
    end
endmodule
