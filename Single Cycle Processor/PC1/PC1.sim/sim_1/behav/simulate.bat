@echo off
set xv_path=C:\\Xilinx\\Vivado\\2016.4\\bin
call %xv_path%/xsim program_counter_sim_behav -key {Behavioral:sim_1:Functional:program_counter_sim} -tclbatch program_counter_sim.tcl -view E:/B. Tech II year/CSN_221/Project/32-bit-MIPS-Processor-master/Modules/Program Counter/program_counter_sim_behav.wcfg -view E:/B. Tech II year/CSN_221/Project/32-bit-MIPS-Processor-master/Modules/Program Counter/program_counter_sim_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
