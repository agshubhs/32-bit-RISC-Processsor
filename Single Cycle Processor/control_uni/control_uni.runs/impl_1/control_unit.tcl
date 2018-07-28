proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir {E:/B. Tech II year/CSN_221/Project/32-bit-MIPS-Processor-master/Final program/control_uni/control_uni.cache/wt} [current_project]
  set_property parent.project_path {E:/B. Tech II year/CSN_221/Project/32-bit-MIPS-Processor-master/Final program/control_uni/control_uni.xpr} [current_project]
  set_property ip_output_repo {{E:/B. Tech II year/CSN_221/Project/32-bit-MIPS-Processor-master/Final program/control_uni/control_uni.cache/ip}} [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  add_files -quiet {{E:/B. Tech II year/CSN_221/Project/32-bit-MIPS-Processor-master/Final program/control_uni/control_uni.runs/synth_1/control_unit.dcp}}
  link_design -top control_unit -part xc7k70tfbv676-1
  write_hwdef -file control_unit.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force control_unit_opt.dcp
  catch { report_drc -file control_unit_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force control_unit_placed.dcp
  catch { report_io -file control_unit_io_placed.rpt }
  catch { report_utilization -file control_unit_utilization_placed.rpt -pb control_unit_utilization_placed.pb }
  catch { report_control_sets -verbose -file control_unit_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force control_unit_routed.dcp
  catch { report_drc -file control_unit_drc_routed.rpt -pb control_unit_drc_routed.pb -rpx control_unit_drc_routed.rpx }
  catch { report_methodology -file control_unit_methodology_drc_routed.rpt -rpx control_unit_methodology_drc_routed.rpx }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file control_unit_timing_summary_routed.rpt -rpx control_unit_timing_summary_routed.rpx }
  catch { report_power -file control_unit_power_routed.rpt -pb control_unit_power_summary_routed.pb -rpx control_unit_power_routed.rpx }
  catch { report_route_status -file control_unit_route_status.rpt -pb control_unit_route_status.pb }
  catch { report_clock_utilization -file control_unit_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force control_unit_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

