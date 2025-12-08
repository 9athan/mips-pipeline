module instrMem (
    input  wire        clk,
    input  wire        rst,
    input  wire [31:0] addr,
    output reg  [31:0] data
);

    reg [31:0] mem [0:1023];

    integer i;

    initial begin
        for (i = 0; i < 1024; i = i + 1)
            mem[i] = 32'h0000_0000;

        mem[0] = 32'hA00000AA;
        mem[1] = 32'h10000011;
        mem[2] = 32'h20000022;
        mem[3] = 32'h30000033;
        mem[4] = 32'h40000044;
        mem[5] = 32'h50000055;
        mem[6] = 32'h60000066;
        mem[7] = 32'h70000077;
        mem[8] = 32'h80000088;
        mem[9] = 32'h90000099;
    end

    always @(*) begin
        data = mem[addr[31:2]];
    end
endmodule

