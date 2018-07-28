`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 03:10:03 PM
// Design Name: 
// Module Name: control_unit
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


 module control_unit(
 input [5:0]opcode,
 output RegDst,
 output AluSrc,
 output MemtoReg,
 output RegWrite,
 output MemRead,
 output MemWrite,
 output Branch,
 output Jump
 );
  reg RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Jump,Branch;

 always @(*)
    begin
    case(opcode)
                   
     6'b000000 :  begin    //rformat  add
                  RegDst=1;
                  AluSrc=0;
                  MemtoReg=0;
                  RegWrite=1;
                  MemRead=0;
                  MemWrite=0;
                  Branch=0;
                  Jump=0;
                  end
     6'b000001:    begin  //   and
                   RegDst=1;
                   AluSrc=0;
                   MemtoReg=0;
                   RegWrite=1;
                   MemRead=0;
                   MemWrite=0;
                   Branch=0;
                   Jump=0;
                   end
     6'b000010:    begin    /// or
                   RegDst=1;
                   AluSrc=0;
                   MemtoReg=0;
                   RegWrite=1;
                   MemRead=0;
                   MemWrite=0;
                   Branch=0;
                   Jump=0;
                   end
  6'b000011:       begin   // xor
                   RegDst=1;
                   AluSrc=0;
                   MemtoReg=0;
                   RegWrite=1;
                   MemRead=0;
                   MemWrite=0;
                   Branch=0;
                   Jump=0;
                   end              
   6'b000100:      begin // subtract
                   RegDst=1;
                   AluSrc=0;
                   MemtoReg=0;
                   RegWrite=1;
                   MemRead=0;
                   MemWrite=0;
                   Branch=0;
                   Jump=0;
                   end
   6'b000010:      begin  // set less than
                   RegDst=1;
                   AluSrc=0;
                   MemtoReg=0;
                   RegWrite=1;
                   MemRead=0;
                   MemWrite=0;
                   Branch=0;
                   Jump=0;
                  end
           
   6'b011111 :  begin      //load
                  RegDst=0;
                  AluSrc=1;
                  MemtoReg=1;
                  RegWrite=1;
                  MemRead=1;
                  MemWrite=0;
                  Branch=0;
                  Jump=0;
                  end
    6'b011101 :   begin   //store
                  RegDst=1'bx;
                  AluSrc=1;
                  MemtoReg=1'bX;
                  RegWrite=0;
                  MemRead=0;
                  MemWrite=1;
                  Branch=0;
                  Jump=0;
                  end
   6'b110000  :    begin  //branch or branch not equal
                 RegDst=1'bx;
                 AluSrc=0;
                 MemtoReg=1'bx;
                 RegWrite=0;
                 MemRead=0;
                 MemWrite=0;
                 Branch=1;
                 Jump=0;
                end
   6'b110001 :   begin  // branch not equal
                 RegDst=1'bx;
                 AluSrc=0;
                 MemtoReg=1'bx;
                 RegWrite=0;
                 MemRead=0;
                 MemWrite=0;
                 Branch=1;
                 Jump=0;
                 end             
   6'b010000 : begin          //addi
              RegDst=0;
              AluSrc=1;
              MemtoReg=0;
              RegWrite=1;
              MemRead=0;
              MemWrite=0;
              Branch=0;
              Jump=0;
              end
   6'b010001 : begin          //andi
              RegDst=0;
              AluSrc=1;
              MemtoReg=0;
              RegWrite=1;
              MemRead=0;
              MemWrite=0;
              Branch=0;
              Jump=0;
              end
   6'b010010 : begin        //ori
               RegDst=0;
               AluSrc=1;
               MemtoReg=0;
               RegWrite=1;
               MemRead=0;
               MemWrite=0;
               Branch=0;
               Jump=0;
               end
    6'b010011 : begin          //xori
                RegDst=0;
                AluSrc=1;
                MemtoReg=0;
                RegWrite=1;
                MemRead=0;
                MemWrite=0;
                Branch=0;
                Jump=0;
                end
                                                              
  6'b010101 : begin           //slti
              RegDst=0;
              AluSrc=1;
              MemtoReg=0;
              RegWrite=1;
              MemRead=0;
              MemWrite=0;
              Branch=0;
              Jump=0;
              end
   6'b110010 :  begin              //jump
              RegDst= 1'bx;
              AluSrc= 1'bx;
              MemtoReg= 1'bx;
              RegWrite= 0;
              MemWrite=0;
              MemRead=0;
              Branch=1'bx;
              Jump=1;
              end
  default :   begin
              RegDst=1'b0;
              AluSrc=1'b0;
              MemtoReg=1'b0;
              RegWrite=1'b0;
              MemRead=1'b0;
              MemWrite=1'b0;
              Branch=1'b0;
              Jump=1'b0;
              end
   endcase
   end     
endmodule
