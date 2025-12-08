`timescale 1ns/1ps

module tb_fetch;
    reg         clk;
    reg         rst;
    reg         ex_mem_pc_src;
    reg  [31:0] ex_mem_npc;
    wire [31:0] if_id_instr; 
    wire [31:0] if_id_npc;


    fetch dut (
        .clk           (clk),
        .rst           (rst),
        .ex_mem_pc_src (ex_mem_pc_src),
        .ex_mem_npc    (ex_mem_npc),
        .if_id_instr   (if_id_instr),
        .if_id_npc     (if_id_npc)
    );


    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    initial begin

        $dumpfile("fetch.vcd");
        $dumpvars(0, tb_fetch);

   
        rst = 1;
        ex_mem_pc_src = 0;
        ex_mem_npc    = 32'h0000_0004; 


        #12; rst = 0;

    
        repeat (6) @(posedge clk);

   
        @(posedge clk);
        ex_mem_pc_src <= 1;
        @(posedge clk);
        ex_mem_pc_src <= 0;

    
        repeat (8) @(posedge clk);

        $finish;
    end
endmodule
