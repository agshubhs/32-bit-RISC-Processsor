`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 05:58:11 PM
// Design Name: 
// Module Name: data_memory_testbench
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
module  data_memory_testbench();
reg clk;
reg  [31:0]adres;  
reg [31:0]write_data;  
wire [31:0]read_data ;
reg  mem_read;
reg  mem_write;
data uut(.adres(adres),.write_data(write_data),.read_data(read_data),.mem_read(mem_read),.mem_write(mem_write));
initial begin
clk=0;
adres =0;
write_data=0;
mem_read=0;
mem_write=0;
# 10 
mem_write =1;
     adres=32'b00000000000000000000000000000001;
write_data=32'b00000000000000000000000000000111;
#10  adres=32'b00000000000000000000000000000011;
write_data=32'b00000000000000000000000000001111;
#10  adres=32'b00000000000000000000000000000010;
write_data=32'b00000000000000000000000000000101;
#10 mem_write=0;
mem_read =1;
#10 adres=32'b00000000000000000000000000000001;// data stored in the address 1 will be forwarded
#10 adres=32'b00000000000000000000000000000011;
#10 adres=32'b00000000000000000000000000000010;
#10 adres=32'b00000000000000000000000000001111;// no data so output is zero
end
endmodule
