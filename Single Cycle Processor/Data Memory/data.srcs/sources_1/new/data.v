`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2017 05:55:24 PM
// Design Name: 
// Module Name: data
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



module data(clk,adres,write_data,read_data,MemWrite,MemRead);
    input    clk;  
      input  [31:0] adres;  
      input  [31:0] write_data;  
      output [31:0] read_data ;
      input  MemRead;
      input MemWrite;  
      integer i;  
      reg [31:0] mem [255:0];  
      wire[31: 0] mem_addr = adres[31 : 0]; 
       reg [31:0] read_data;
       
      initial begin  
           for(i=1;i<256;i=i+1)  
                mem[i] <= 32'b00000000000000000000000000000000;  
                mem[0] <= 32'b00000000000000000000000000000111;
      end
      
        
      always @(posedge clk) begin  
           if (MemWrite) 
           begin 
                mem[mem_addr] <= write_data;  
           end   
      
           if(MemRead)begin
                read_data <= mem[mem_addr];
        
           end else begin 
              read_data<= 32'b0;
           end
     end
 endmodule
