`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2017 20:21:45
// Design Name: 
// Module Name: ALU_CU
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


module ALU_CU(
    input [5:0] opcode,
    output reg [3:0] alu_cu
    );
    
    always @(opcode)
    begin
    case(opcode)
        6'b000000:   alu_cu = 4'b0000;//  add
        6'b000001:   alu_cu = 4'b0001;// and
        6'b000010:   alu_cu = 4'b0010;  // or
        6'b000011:   alu_cu = 4'b0011; // xor
        6'b000100:   alu_cu = 4'b1000; //subtract  
        6'b000101:   alu_cu = 4'b0100;   // set less than 
  
  //  I Type
        6'b010000:   alu_cu = 4'b0000;//  add
        6'b010001:   alu_cu = 4'b0001;// and
        6'b010010:   alu_cu = 4'b0010;  // or
        6'b010011:   alu_cu = 4'b0011; // xor  
        6'b010101:   alu_cu = 4'b0100;   // set less than 
        6'b011111:   alu_cu = 4'b0000;  // load word
        6'b011101:   alu_cu = 4'b0000;   // store word
    
    //  J Type
        6'b110000:   alu_cu = 4'b1000;  // beq 
        6'b110001:   alu_cu = 4'b1000;   // bnq 
     //   6'b110010:   alu_cu = 4'b0100; // jump
       default: alu_cu = 4'b0000;
 endcase    
end
endmodule
