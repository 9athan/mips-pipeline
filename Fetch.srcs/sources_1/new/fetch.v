// Top-level IF stage you were given (completed)
module fetch(
    input  wire        clk,
    input  wire        rst,
    input  wire        ex_mem_pc_src,       // 1: take branch target, 0: sequential
    input  wire [31:0] ex_mem_npc,          // branch/target PC from EX/MEM
    output wire [31:0] if_id_instr,         // latched instruction
    output wire [31:0] if_id_npc            // latched next PC (PC+4)
);
    // internal nets
    wire [31:0] pc_out;     // current PC
    wire [31:0] pc_plus4;   // PC + 4
    wire [31:0] pc_mux;     // next PC before PC register
    wire [31:0] instr_data; // instruction word

    // choose next PC: branch target vs sequential
    mux2 m0 (
        .a_true  (ex_mem_npc),  // when sel=1
        .b_false (pc_plus4),    // when sel=0
        .sel     (ex_mem_pc_src),
        .y       (pc_mux)
    );

    // program counter register
    pc pc0 (
        .clk    (clk),
        .rst    (rst),
        .pc_in  (pc_mux),
        .pc_out (pc_out)
    );

    // +4 adder
    incrementer in0 (
        .pcin  (pc_out),
        .pcout (pc_plus4)
    );

    // instruction memory (registered read -> 1 cycle latency)
    instrMem inMem0 (
        .clk  (clk),
        .rst  (rst),
        .addr (pc_out),      // byte address
        .data (instr_data)
    );

    // IF/ID latch
    ifIdLatch ifIdLatch0 (
        .clk      (clk),
        .rst      (rst),
        .pc_in    (pc_plus4),
        .instr_in (instr_data),
        .pc_out   (if_id_npc),
        .instr_out(if_id_instr)
    );
endmodule
