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



module data(clk,adres1,write_data1,read_data1,MemWrite1,MemRead1,adres2,write_data2,read_data2,MemWrite2,MemRead2);
    input    clk;  
      input  [31:0] adres1,adres2;  
      input  [31:0] write_data1, write_data2;  
      output [31:0] read_data1,read_data2 ;
      input  MemRead1,MemRead2;
      input MemWrite1, MemWrite2;  
      integer i;  
      reg [31:0] mem [255:0];  
      wire[31: 0] mem_addr1 = adres1[31 : 0]; 
      wire[31: 0] mem_addr2 = adres2[31 : 0]; 
       reg [31:0] read_data1, read_data2;
       
      initial begin  
           for(i=1;i<256;i=i+1)  
                mem[i] <= 32'b00000000000000000000000000000000;  
                mem[0] <= 32'b00000000000000000000000000000111;
      end
      
        
      always @(posedge clk) begin  
           if (MemWrite1) 
           begin 
                mem[mem_addr1] <= write_data1;  
           end   
      
           if(MemRead1)
           begin
                read_data1 <= mem[mem_addr1];
        
           end 
           else 
           begin 
              read_data1<= 32'b0;
           end
          
          
          if (MemWrite2) 
          begin 
            mem[mem_addr2] <= write_data2;  
          end   
                 
          if(MemRead2)
          begin
             read_data2 <= mem[mem_addr2];
          end 
          else 
          begin 
          read_data2<= 32'b0;
          end    
     end
 endmodule
