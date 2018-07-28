`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 03:15:39 PM
// Design Name: 
// Module Name: test_bench
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

module test_bench();
reg [5:0]opcode;
wire RegDst, AluSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump;
//wire [1:0] ALUOp;
control_unit uut(
 
.opcode(opcode),
.RegDst(RegDst),
.AluSrc(AluSrc),
.MemtoReg(MemtoReg),
.RegWrite(RegWrite),
.MemRead(MemRead),
.MemWrite(MemWrite),
.Branch(Branch),
.Jump(Jump)
  );
 
initial
begin
    opcode =6'b000000;   //rformat
#10 opcode=6'b000001;    
#10 opcode=6'b000010;    
#10 opcode=6'b000011;    
#10 opcode=6'b000101;    
#10 opcode=6'b000100;    
#10 opcode=6'b000101;    
#10 opcode=6'b011101; // store word   
#10 opcode=6'b011111; // load word   
#10 opcode=6'b010101;//set less than    
#10 opcode=6'b010010;    // i format
#10 opcode=6'b110000; // branch
#10 opcode=6'b110010; //   jump
end 
endmodule
