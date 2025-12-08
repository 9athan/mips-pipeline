// PC: on each rising clock, forwards pc_in to pc_out
module pc (
    input  wire        clk,
    input  wire        rst,       // synchronous reset
    input  wire [31:0] pc_in,
    output reg  [31:0] pc_out
);
    always @(posedge clk) begin
        if (rst) pc_out <= 32'h0000_0000;
        else     pc_out <= pc_in;
    end
endmodule
