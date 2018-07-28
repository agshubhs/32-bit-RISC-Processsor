`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2017 03:59:21 PM
// Design Name: 
// Module Name: combine
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


module combine(
input clk,
output wire [31:0] res,
output wire [31:0] pc_out,
output Z,
output N,
output wire [31:0] instruction 
);
reg [31:0] pc_current;
//wire [31:0]instruction;
wire signed[31:0] pc_next,pc2;
wire [5:0]opcode;
wire [4:0]ins25_21;//  rs
wire [4:0]ins20_16;//rd
wire [4:0]ins15_11;
wire [15:0]ins15_0;
wire[26:0] ins25_0;
wire [3:0] alu_cu;
wire RegDst,AluSrc,MemtoReg,RegWrite,MemRead,MemWrite,Jump,Branch;
wire [4:0] WReg;
wire [31:0] WData;
wire [31:0] RData1,RData2;
wire [31:0] read_data;
wire [31:0] sign_extend;
wire [31:0] B;
wire [31:0] pc_beqt,pc4_beqj;
wire [29:0] jump_shift;
wire branch_signal;
wire [31:0] jump_offset;
//program_counter program_counter(.clk(clk),.pc_out(pc_current));
initial
begin
pc_current= 32'h00000000;
end
always@(posedge clk)
   begin
   pc_current<=pc_next;
   end
 assign  pc2= pc_current+32'd4;
instr_mem instruction_memory(.addr1(pc_current),.instruction1(instruction[31:0]));
  
assign opcode =instruction[31:26];
assign ins25_21=instruction[25:21];
assign ins20_16=instruction[20:16];
assign ins15_11=instruction[15:11];
assign ins15_0=instruction[15:0];
assign ins25_0=instruction[25:0];

control_unit control_unit(.opcode(opcode),.RegDst(RegDst),
.AluSrc(AluSrc),.MemtoReg(MemtoReg),.RegWrite(RegWrite),
.MemRead(MemRead),.MemWrite(MemWrite),.Jump(Jump),.Branch(Branch));

assign WReg=(RegDst==1'b1) ? ins15_11:ins20_16;

reg_file reg_file(.clk(clk),.RegWrite(RegWrite),
.ins25_21(ins25_21),.ins20_16(ins20_16),
.RData1(RData1),.RData2(RData2),.WData(WData),.WReg(WReg));

ALU_CU ALUCU(.opcode(opcode),.alu_cu(alu_cu));

assign sign_extend={{16{instruction[15]}},ins15_0};
  assign pc_beqt= {sign_extend[29:0],2'b00};
  assign branch_signal=  Branch & Z;
  assign pc4_beqj=(branch_signal==1) ?pc_beqt:pc2;
  assign jump_offset={ins25_0,2'b00,pc2[31:28]};
  assign pc_next=(Jump==1)? jump_offset:pc4_beqj;

assign B=(AluSrc==1'b1) ?sign_extend:RData2;

Alu Alu(.alu_cu(alu_cu),.A(RData1),.B(B),.res(res),.Z(Z),.N(N));
data data(.clk(clk),.adres(res),.write_data(RData2),.read_data(read_data),
.MemRead(MemRead),.MemWrite(MemWrite));
assign WData = (MemtoReg==1'b1) ? read_data: res;
assign pc_out=pc_current;
endmodule
