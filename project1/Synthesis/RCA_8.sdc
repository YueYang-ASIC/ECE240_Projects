###################################################################

# Created by write_sdc on Wed Feb 19 01:02:40 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_area 0
set_load -pin_load 1.5 [get_ports {SUM[7]}]
set_load -pin_load 1.5 [get_ports {SUM[6]}]
set_load -pin_load 1.5 [get_ports {SUM[5]}]
set_load -pin_load 1.5 [get_ports {SUM[4]}]
set_load -pin_load 1.5 [get_ports {SUM[3]}]
set_load -pin_load 1.5 [get_ports {SUM[2]}]
set_load -pin_load 1.5 [get_ports {SUM[1]}]
set_load -pin_load 1.5 [get_ports {SUM[0]}]
set_load -pin_load 1.5 [get_ports COUT]
create_clock [get_ports clk]  -period 4  -waveform {0 2}
set_clock_uncertainty 0.2  [get_clocks clk]
set_input_delay -clock clk  0.12  [get_ports clk]
set_input_delay -clock clk  0.12  [get_ports {A[7]}]
set_input_delay -clock clk  0.12  [get_ports {A[6]}]
set_input_delay -clock clk  0.12  [get_ports {A[5]}]
set_input_delay -clock clk  0.12  [get_ports {A[4]}]
set_input_delay -clock clk  0.12  [get_ports {A[3]}]
set_input_delay -clock clk  0.12  [get_ports {A[2]}]
set_input_delay -clock clk  0.12  [get_ports {A[1]}]
set_input_delay -clock clk  0.12  [get_ports {A[0]}]
set_input_delay -clock clk  0.12  [get_ports {B[7]}]
set_input_delay -clock clk  0.12  [get_ports {B[6]}]
set_input_delay -clock clk  0.12  [get_ports {B[5]}]
set_input_delay -clock clk  0.12  [get_ports {B[4]}]
set_input_delay -clock clk  0.12  [get_ports {B[3]}]
set_input_delay -clock clk  0.12  [get_ports {B[2]}]
set_input_delay -clock clk  0.12  [get_ports {B[1]}]
set_input_delay -clock clk  0.12  [get_ports {B[0]}]
set_input_delay -clock clk  0.12  [get_ports CIN]
set_output_delay -clock clk  0.16  [get_ports {SUM[7]}]
set_output_delay -clock clk  0.16  [get_ports {SUM[6]}]
set_output_delay -clock clk  0.16  [get_ports {SUM[5]}]
set_output_delay -clock clk  0.16  [get_ports {SUM[4]}]
set_output_delay -clock clk  0.16  [get_ports {SUM[3]}]
set_output_delay -clock clk  0.16  [get_ports {SUM[2]}]
set_output_delay -clock clk  0.16  [get_ports {SUM[1]}]
set_output_delay -clock clk  0.16  [get_ports {SUM[0]}]
set_output_delay -clock clk  0.16  [get_ports COUT]
