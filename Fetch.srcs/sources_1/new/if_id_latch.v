module ifIdLatch (
    input  wire        clk,
    input  wire        rst,         // clear
    input  wire [31:0] pc_in,       // PC+4
    input  wire [31:0] instr_in,
    output reg  [31:0] pc_out,
    output reg  [31:0] instr_out
);
    always @(posedge clk) begin
        if (rst) begin
            pc_out    <= 32'h0000_0000;
            instr_out <= 32'h0000_0000;
        end else begin
            pc_out    <= pc_in;
            instr_out <= instr_in;
        end
    end
endmodule

