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
output wire [31:0] res1,
output wire [31:0] res2,
output wire [31:0] pc_out1,
output wire [31:0] pc_out2,
output Z1,
output Z2,
output N1,
output N2,
input [31:0] instruction1,
input [31:0] instruction2, 
input  [31:0]pc_current1,
input [31:0]pc_current2,
output wire signed [31:0]pc_next1,
output wire signed [31:0]pc_next2
);


wire signed[31:0]pc2_1 ;  //  for first only
wire [5:0]opcode1;
wire [4:0]ins25_21_1;//  rs
wire [4:0]ins20_16_1;//rd
wire [4:0]ins15_11_1;
wire [15:0]ins15_0_1;
wire[25:0] ins25_0_1;
wire RegDst1,AluSrc1,MemtoReg1,RegWrite1,MemRead1,MemWrite1,Jump1,Branch1;
wire [3:0] alu_cu1;
wire [4:0] WReg1;
wire [31:0] WData1,RData1_1,RData1_2,read_data1;
wire [31:0] sign_extend_1;

wire signed[31:0]pc2_2;
wire [5:0]opcode2;
wire [4:0]ins25_21_2;//  rs
wire [4:0]ins20_16_2;//rd
wire [4:0]ins15_11_2;
wire [15:0]ins15_0_2;
wire[25:0] ins25_0_2;
wire RegDst2,AluSrc2,MemtoReg2,RegWrite2,MemRead2,MemWrite2,Jump2,Branch2;
wire [3:0] alu_cu2;
wire [4:0] WReg2;
wire [31:0] WData2,RData2_1,RData2_2;
wire [31:0] read_data2;
wire [31:0] sign_extend_2;
wire [31:0] B1,B2;

// for p1 only;

wire [31:0] pc_beqt,pc4_beqj;
wire [29:0] jump_shift;
wire branch_signal;
wire [31:0] jump_offset;

assign  pc2_1= pc_current1+32'd8;
assign pc2_2= pc_current2+32'd8;

  
assign opcode1=instruction1[31:26];
assign ins25_21_1=instruction1[25:21];
assign ins20_16_1=instruction1[20:16];
assign ins15_11_1=instruction1[15:11];
assign ins15_0_1=instruction1[15:0];
assign ins25_0_1=instruction1[25:0];

assign opcode2 =instruction2[31:26];
assign ins25_21_2=instruction2[25:21];
assign ins20_16_2=instruction2[20:16];
assign ins15_11_2=instruction2[15:11];
assign ins15_0_2=instruction2[15:0];
assign ins25_0_2=instruction2[25:0];

//  CONTROL SIGNAL FOR THE INSTRUCTION 1 
control_unit control_unit1(.opcode(opcode1),.RegDst(RegDst1),
.AluSrc(AluSrc1),.MemtoReg(MemtoReg1),.RegWrite(RegWrite1),
.MemRead(MemRead1),.MemWrite(MemWrite1),.Jump(Jump1),.Branch(Branch1));

// CONTROL SIGNAL FOR THE INSTRUCTION 2
control_unit control_unit2(.opcode(opcode2),.RegDst(RegDst2),
.AluSrc(AluSrc2),.MemtoReg(MemtoReg2),.RegWrite(RegWrite2),
.MemRead(MemRead2),.MemWrite(MemWrite2));

// ALU CONTROL UNIT FOR BOTH THE INSTRUCTION
ALU_CU ALUCU1(.opcode(opcode1),.alu_cu(alu_cu1));
ALU_CU ALUCU2(.opcode(opcode2),.alu_cu(alu_cu2));

assign WReg1=(RegDst1==1'b1) ? ins15_11_1:ins20_16_1;
assign WReg2=(RegDst2==1'b1) ? ins15_11_2:ins20_16_2;


// ACCESING REGISTER FILE
 reg_file reg_file(.clk(clk),.RegWrite1(RegWrite1),.RegWrite2(RegWrite2),
 .ins25_21_1(ins25_21_1),.ins20_16_1(ins20_16_1),
 .ins25_21_2(ins25_21_2),.ins20_16_2(ins20_16_2),
 .RData1_1(RData1_1),.RData2_1(RData2_1),.WData1(WData1),.WReg1(WReg1),
 .RData1_2(RData1_2),.RData2_2(RData2_2),.WData2(WData2),.WReg2(WReg2));


  assign sign_extend_1={{16{instruction1[15]}},ins15_0_1};
  assign sign_extend_2={{16{instruction2[15]}},ins15_0_2};

  assign B1=(AluSrc1==1'b1) ?sign_extend_1:RData2_1;
  assign B2=(AluSrc2==1'b1) ?sign_extend_2:RData2_2;


// ALU OPERATION FOR BOTH THE UNITS
Alu Alu1(.alu_cu(alu_cu1),.A(RData1_1),.B(B1),.res(res1),.Z(Z1),.N(N1));
Alu Alu2(.alu_cu(alu_cu2),.A(RData1_2),.B(B2),.res(res2),.Z(Z2),.N(N2));


  // BRANCH OR JUMP PREDICTION FOR INSTRUCTION 1
  assign pc_beqt= {sign_extend_1[29:0],2'b00};
  assign jump_offset={ins25_0_1,2'b00,pc2_1[31:28]};
  assign branch_signal=  Branch1 & Z1;  
  assign pc4_beqj=(branch_signal==1) ?pc_beqt:pc2_1;  //
  
  
  
  assign pc_next1=(Jump1==1)? jump_offset:pc4_beqj; ///
  assign pc_next2= pc2_2;

// ACCESSING DATA MEMORY
data data(.clk(clk),.adres1(res1),.write_data1(RData2_1),.read_data1(read_data1),
.MemRead1(MemRead1),.MemWrite1(MemWrite1),
.adres2(res2),.write_data2(RData2_2),.read_data2(read_data2),
.MemRead2(MemRead2),.MemWrite2(MemWrite2));


assign WData1 = (MemtoReg1==1'b1) ? read_data1: res1;
assign WData2 = (MemtoReg2==1'b1) ? read_data2: res2;



assign pc_out1=pc_current1;
assign pc_out2=pc_current2;


endmodule
