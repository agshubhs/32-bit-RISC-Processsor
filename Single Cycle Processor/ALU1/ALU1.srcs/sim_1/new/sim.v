`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2017 21:36:33
// Design Name: 
// Module Name: sim
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


module sim;
    reg [3:0] alu_cu;
    reg [31:0] A;
    reg [31:0] B;
    wire [31:0] res;
    wire Z;
    wire N;
    
Alu uut(
    .alu_cu(alu_cu),
    .A(A),
    .B(B),
    .res(res),
    .Z(Z),
    .N(N)
    );
    
    initial begin
    A = 32'b00000000000000000000000000000011 ; 
    B = 32'b00000000000000000000000000000110 ;
    alu_cu = 4'b0000;
    #50; alu_cu = 4'b1000;
    #50; alu_cu = 4'b0001;
    #50; alu_cu = 4'b0010;
    #50; alu_cu = 4'b0011;
    #50; alu_cu = 4'b0100;
    end
    
   
endmodule