`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.09.2017 22:34:36
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


module sim();
    reg [5:0] opcode;
    wire [3:0] alu_cu;
    
    ALU_CU uut(
    .opcode(opcode),
    .alu_cu(alu_cu)
    );
   integer i; 
    initial begin 
    for(i=0;i<64;i=i+1)
     begin  
       opcode=i;
       #10;     
    end
    end
    endmodule
