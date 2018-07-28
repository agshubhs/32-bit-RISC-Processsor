`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2017 12:49:12
// Design Name: 
// Module Name: program_counter
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


module program_counter(
    input wire clk,
  //  input wire [31:0] branch_addr,
    //input wire branch_signal,
    //input wire [25:0] jmp_addr,
    //input wire jmp_signal,
    output wire [31:0] pc_out
    );
    
    reg [31:0]  pc_reg;
    wire [31:0] pc_plus_four;
    //wire [31:0] branch_out;
    //wire [31:0] jmp_out;
    //wire [31:0] jmp_addr_1;
    
    assign pc_out = pc_reg;
    assign pc_plus_four = pc_out + 32'd4;
   // assign branch_out = pc_plus_four + branch_addr;
   // assign jmp_addr_1[27:2] = jmp_addr[25:0];
   // assign jmp_addr_1[1:0] = 2'b00;
   // assign jmp_addr_1[31:28] = pc_plus_four [31:28];
   // assign jmp_out = jmp_addr;
    
    initial begin
        pc_reg= 32'h00000000;
    end
        
    always @(posedge clk) begin
   //  if(jmp_signal == 1'b0)
    // begin
     // if(branch_signal == 1'b0)
        pc_reg = pc_plus_four;
     // else
      //  pc_reg = branch_out;    
     end
   //  else
      // pc_reg = jmp_out;
    //end
    
endmodule
