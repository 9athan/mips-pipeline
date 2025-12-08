`timescale 1ns / 1ps
// mux2.v
// Generic 2:1 multiplexer with parameterized width

module mux2 #(parameter WIDTH = 32) (
    input  wire [WIDTH-1:0] a_true,   // selected when sel = 1
    input  wire [WIDTH-1:0] b_false,  // selected when sel = 0
    input  wire             sel,
    output wire [WIDTH-1:0] y
);

    assign y = (sel) ? a_true : b_false;

endmodule

