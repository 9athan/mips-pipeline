`timescale 1ns/1ps
module control(
    input  wire       clk,    
    input  wire       rst,    
    input  wire [5:0] opcode,

    output reg  [1:0] wb,
    output reg  [2:0] mem,
    output reg  [3:0] ex
);
    // opcodes
    localparam OP_R   = 6'b000000;
    localparam OP_LW  = 6'b100011;
    localparam OP_SW  = 6'b101011;
    localparam OP_BEQ = 6'b000100;

    always @* begin
       
        wb  = 2'b00;           
        mem = 3'b000;          
        ex  = 4'b0000;         

        case (opcode)
            OP_R: begin
               
                ex  = 4'b1100;
                mem = 3'b000;
                wb  = 2'b10;
            end
            OP_LW: begin
               
                ex  = 4'b0001;
                mem = 3'b010;
                wb  = 2'b11;
            end
            OP_SW: begin
               
                ex  = 4'b0001;
                mem = 3'b001;
                wb  = 2'b00;
            end
            OP_BEQ: begin
            
                ex  = 4'b0010;
                mem = 3'b100;
                wb  = 2'b00;
            end
            default: begin
             
                ex  = 4'b0000;
                mem = 3'b000;
                wb  = 2'b00;
            end
        endcase
    end
endmodule
