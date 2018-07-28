`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2017 04:23:06 PM
// Design Name: 
// Module Name: final
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


module final();
wire [31:0] pc_out1, pc_out2;
reg clk;
wire [31:0] res1,res2;
// Register;
wire Z1,N1,Z2,N2;
wire [31:0]instruction1;
wire  [31:0]instruction2;

    
    superscalar uut(
    .pc_out1(pc_out1),
    .pc_out2(pc_out2),
    .res1(res1),
    .res2(res2),
    .Z1(Z1),
    .Z2(Z2),
    .N1(N1),
    .N2(N2),
    .clk(clk),
    .instruction1(instruction1),
    .instruction2(instruction2)
    );
    
 initial 
 begin   
clk=0;
forever
#20 clk =~clk;
end/*
initial 
begin
// #10 instruction = 32'b0000111111111111111111111111111;
// #10 instruction = 32'b0001001111111111111000000000000;
 end*/
endmodule
