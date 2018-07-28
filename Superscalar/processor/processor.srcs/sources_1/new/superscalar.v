`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2017 12:11:30 PM
// Design Name: 
// Module Name: superscalar
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


module superscalar( 
input clk,
output wire [31:0] res1,
output wire [31:0] pc_out1,
output Z1,
output N1,
output wire [31:0] res2,
output wire [31:0] pc_out2,
output Z2,
output N2,
output wire [31:0] instruction1,
output wire [31:0] instruction2
);
reg [31:0] pc_current1;
reg [31:0] pc_current2;
wire [31:0] pc_next1,pc_next2;
wire [31:0] i1,i2, hold;
wire [31:0]pc_c1,pc_c2,hold_pc;

initial
begin 
pc_current1= 32'h00000000;
pc_current2=32'd4;
end
instr_mem instruction_memory(.addr1(pc_current1),.addr2(pc_current2),.instruction1(instruction1),.instruction2(instruction2));
always@(posedge clk)
   begin
   pc_current1<=pc_next1;
   pc_current2<=pc_next2;
   end
 /*  initial
    begin
    assign hold = 32'hffffffff;
    assign hold_pc = 32'hffffffff;
    end*/
   
 
 /* assign i1 =   (hold != 32'hffffffff) ? hold : instruction1;
  assign pc_c1 =   (hold != 32'hffffffff) ? hold_pc : pc_current1;
  assign i2= ( instruction1[15:11]==instruction2[15:11]) ? 32'hffffffff: instruction2;
 assign pc_c2=( instruction1[15:11]==instruction2[15:11])?32'hffffffff: pc_current2;
 
 assign  hold = ( instruction1[15:11]==instruction2[15:11]) ? instruction2: 32'hffffffff; 
 assign  hold_pc=( instruction1[15:11]==instruction2[15:11]) ? pc_current2: 32'hffffffff;
 
  *
/*  if  (hold != 32'bxxx)
         begin
         assign  i1 = hold;
         assign  pc_c1=hold_pc; 
         end
    else 
         begin
         assign i1 = instruction1;    
         assign pc_c1=pc_current1;   
         end
   if(dependencies)
         begin
         assign hold = instruction2;
         assign hold_pc  = pc_current2;
         assign i2 =  32'bxxx;
         assign pc_c2=32'bxxxx;
          end
   else
         begin
         assign i2=instruction2;
         assign pc_c2=pc_current2;
         assign hold =32'bxxxx;
         assign hold_pc=32'bxxxx; 
         end
  
   if a[15:11]==b[15:11] :
             print("WAW")
         if a[17:22]==b[15:11] or a[12:17]==b[15:11]:
             print ("RAW")
         if a[15:11]==b[17:22] or a[15:11]==b[12:17] :
             print("WAR")




*/

combine processor(.pc_current1(pc_current1),.clk(clk),.res1(res1),.Z1(Z1),.N1(N1),
.pc_out1(pc_out1),.instruction1(instruction1),.pc_next1(pc_next1),
.pc_current2(pc_current2),.res2(res2),.Z2(Z2),.N2(N2),
.pc_out2(pc_out2),.instruction2(instruction2),.pc_next2(pc_next2));


endmodule
