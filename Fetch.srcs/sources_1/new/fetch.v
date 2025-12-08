module fetch(
    input  wire        clk,
    input  wire        rst,
    input  wire        ex_mem_pc_src,       
    input  wire [31:0] ex_mem_npc,         
    output wire [31:0] if_id_instr,         
    output wire [31:0] if_id_npc            
);
    wire [31:0] pc_out;     
    wire [31:0] pc_plus4;   
    wire [31:0] pc_mux;    
    wire [31:0] instr_data; 

    mux2 m0 (
        .a_true  (ex_mem_npc), 
        .b_false (pc_plus4),    
        .sel     (ex_mem_pc_src),
        .y       (pc_mux)
    );

    pc pc0 (
        .clk    (clk),
        .rst    (rst),
        .pc_in  (pc_mux),
        .pc_out (pc_out)
    );

    incrementer in0 (
        .pcin  (pc_out),
        .pcout (pc_plus4)
    );

    instrMem inMem0 (
        .clk  (clk),
        .rst  (rst),
        .addr (pc_out),      
        .data (instr_data)
    );

    ifIdLatch ifIdLatch0 (
        .clk      (clk),
        .rst      (rst),
        .pc_in    (pc_plus4),
        .instr_in (instr_data),
        .pc_out   (if_id_npc),
        .instr_out(if_id_instr)
    );
endmodule

