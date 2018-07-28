`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2017 13:09:56
// Design Name: 
// Module Name: program_counter_sim
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


module program_counter_sim;
    reg clk;
    wire [31:0] pc_out;
    reg [31:0] branch_addr;
    reg branch_signal;
    reg [25:0] jmp_addr;
    reg jmp_signal;
    

    program_counter uut(
        .clk(clk),
        .branch_addr(branch_addr),
        .pc_out(pc_out),
        .branch_signal(branch_signal),
        .jmp_addr(jmp_addr),
        .jmp_signal(jmp_signal)
        );
    
    initial begin
        clk=0;
        jmp_signal = 1'b0;
        branch_signal=1'b0;   
        branch_addr=8'h01010114;
        jmp_addr=26'b00000000000000100011111100;
    end
    
    always begin
        #50 clk=~clk;
        #50 clk=~clk;
        #50 clk=~clk;
        #50 clk=~clk;
        #50 clk=~clk;
        branch_signal = 1'b1;
        #50 clk=~clk;
        branch_signal = 1'b0;
        #50 clk=~clk;
        jmp_signal = 1'b1;
        #50 clk=~clk;
        jmp_signal = 1'b0;
        #50 clk=~clk;
        #50 clk=~clk;      
                        
    end
    
endmodule
