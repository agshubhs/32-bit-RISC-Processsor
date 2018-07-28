`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2017 21:32:35
// Design Name: 
// Module Name: Alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Alu(
    input [3:0] alu_cu,
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] res,
    output reg Z,
    output reg N
    );
    
    wire [31:0] S;
    wire [31:0] xb;
    assign xb = B ^ {32{alu_cu[3]}};
    assign S = A + xb + alu_cu[3];
    always @(A,B,alu_cu)
    begin
        case(alu_cu)
        4'b0000: res = A+B;  //add,  addi
        4'b1000: res = A-B;  //sub, beq, bne
        4'b0001: res = A&B;  //and , andi
        4'b0010: res = A|B;  //or , ori
        4'b0011: res = A^B;  //xor , xori
        4'b0100:             //slt, slti  
               begin
               if(A<B)
                 res = 8'h00000001;
               else
                 res = 8'h00000000;
               end
               default: res = 8'h00000000;
        endcase
        Z = (S == 32'h00000000);   // When all outputs are zero
        N = S[31];   //Negative number
    end  
endmodule