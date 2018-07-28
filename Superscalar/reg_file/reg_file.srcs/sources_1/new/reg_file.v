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
        input [4:0] ins25_21_1,ins20_16_1,WReg1,ins25_21_2,ins20_16_2,WReg2,
        input [31:0] WData1,WData2,
        input RegWrite1,RegWrite2,clk,
        output [31:0] RData1_1,RData2_1,RData1_2,RData2_2 
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
if (RegWrite1 == 1) 
    begin
      Registers[WReg1] <= WData1;
    end
if (RegWrite2 == 1) 
    begin
      Registers[WReg2] <= WData2;
    end
end
    
    assign  RData1_1 = Registers[ins25_21_1];
    assign  RData2_1 = Registers[ins20_16_1];
    assign  RData1_2 = Registers[ins25_21_2];
    assign RData2_2 = Registers[ins20_16_2];
endmodule
    