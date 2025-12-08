
module mux2 #(parameter WIDTH = 32) (
    input  wire [WIDTH-1:0] a_true,   // selected when sel=1
    input  wire [WIDTH-1:0] b_false,  // selected when sel=0
    input  wire             sel,
    output wire [WIDTH-1:0] y
);
    assign y = sel ? a_true : b_false;
endmodule

