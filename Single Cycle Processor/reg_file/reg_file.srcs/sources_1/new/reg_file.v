`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 03:32:20 PM
// Design Name: 
// Module Name: reg_file
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

module reg_file(
        input [4:0] ins25_21,ins20_16,WReg,
        input [31:0] WData,
        input RegWrite,clk,
        output [31:0] RData1,RData2 
  //      output [31:0] Register
        );        
reg [31:0] Registers [31:0];
integer i; 
 initial 
 begin    
          Registers[0] <= 32'b00000000000000000000000000000001;  
      end

always @(posedge clk)
begin
if (RegWrite == 1) 
    begin
      Registers[WReg] <= WData;
   end
   end
   assign  RData1 = Registers[ins25_21];
    assign RData2 = Registers[ins20_16];
//    assign Register=Registers[2];
     endmodule
    