###################################################################

# Created by write_sdc on Mon Apr 28 18:50:51 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_area 0
set_load -pin_load 1.5 [get_ports {res[0]}]
create_clock [get_ports clk]  -period 0.17  -waveform {0 0.085}
set_clock_uncertainty 0.0085  [get_clocks clk]
set_input_delay -clock clk  0.0051  [get_ports clk]
set_input_delay -clock clk  0.0051  [get_ports rst_n]
set_input_delay -clock clk  0.0051  [get_ports en]
set_input_delay -clock clk  0.0051  [get_ports {A_in[0]}]
set_input_delay -clock clk  0.0051  [get_ports {B_in[0]}]
set_output_delay -clock clk  0.0068  [get_ports {res[0]}]
