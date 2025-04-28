###################################################################

# Created by write_sdc on Mon Apr 28 17:29:51 2025

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current mA
set_max_area 0
set_load -pin_load 1.5 [get_ports {res[3]}]
set_load -pin_load 1.5 [get_ports {res[2]}]
set_load -pin_load 1.5 [get_ports {res[1]}]
set_load -pin_load 1.5 [get_ports {res[0]}]
create_clock [get_ports clk]  -period 0.34  -waveform {0 0.17}
set_clock_uncertainty 0.017  [get_clocks clk]
set_input_delay -clock clk  0.0102  [get_ports clk]
set_input_delay -clock clk  0.0102  [get_ports rst_n]
set_input_delay -clock clk  0.0102  [get_ports en]
set_input_delay -clock clk  0.0102  [get_ports {A_in[3]}]
set_input_delay -clock clk  0.0102  [get_ports {A_in[2]}]
set_input_delay -clock clk  0.0102  [get_ports {A_in[1]}]
set_input_delay -clock clk  0.0102  [get_ports {A_in[0]}]
set_input_delay -clock clk  0.0102  [get_ports {B_in[3]}]
set_input_delay -clock clk  0.0102  [get_ports {B_in[2]}]
set_input_delay -clock clk  0.0102  [get_ports {B_in[1]}]
set_input_delay -clock clk  0.0102  [get_ports {B_in[0]}]
set_output_delay -clock clk  0.0136  [get_ports {res[3]}]
set_output_delay -clock clk  0.0136  [get_ports {res[2]}]
set_output_delay -clock clk  0.0136  [get_ports {res[1]}]
set_output_delay -clock clk  0.0136  [get_ports {res[0]}]
