`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2017 15:25:54
// Design Name: 
// Module Name: instr_mem
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
module instr_mem(
        input wire [31:0] addr1,
        input wire [31:0] addr2,
        output [31:0]  instruction1,
        output [31:0] instruction2
        );        
//wire [7:0]adre=addr[8:1];
reg [31:0] mem [31:0];    
         initial 
         begin
         mem[0]<=32'b00000000000000000000100000000000;  //add r1 r0 r0
         mem[1]<=32'b00010000000000000001000000000000;   //subtract r2 r0 r0
         mem[2]<=32'b00000000000000010001100000000000;    //add r3 r0 r1 
         mem[3]<=32'b01000000000000000000000000000011;   // addi r0 r0 3
         mem[4]<=32'b11111111111111111111111111111111; // unwanted signal
         mem[5]<=32'b01111100000000110000000000000000; //load word from the memory 4 to r3 to base r0
         mem[6]<=32'b01110100000000000000000000001000;  //store word from r0 to mem 12 due to  base value of r0  
          end 
  assign instruction1 =mem[addr1[31:2]];
  assign instruction2 = mem[addr2[31:2]];  
  endmodule


    