// Adds 4 to the incoming PC (pcin -> pcout = pcin + 4)
module incrementer (
    input  wire [31:0] pcin,
    output wire [31:0] pcout
);
    assign pcout = pcin + 32'd4;
endmodule
