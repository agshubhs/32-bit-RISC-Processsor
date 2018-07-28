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
wire [31:0] pc_out;
reg clk;
wire [31:0] res;
// Register;
wire Z,N;
wire [31:0]instruction;

    
    combine uut(
    .pc_out(pc_out),
    .res(res),
    .Z(Z),
    .N(N),
    .clk(clk),
    .instruction(instruction)
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
