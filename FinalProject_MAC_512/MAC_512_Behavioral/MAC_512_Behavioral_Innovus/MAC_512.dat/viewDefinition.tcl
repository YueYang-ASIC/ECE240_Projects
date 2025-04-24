if {![namespace exists ::IMEX]} { namespace eval ::IMEX {} }
set ::IMEX::dataVar [file dirname [file normalize [info script]]]
set ::IMEX::libVar ${::IMEX::dataVar}/libs

create_library_set -name fast\
   -timing\
    [list ${::IMEX::libVar}/mmmc/NangateOpenCellLibrary_fast_ccs.lib]
create_library_set -name worst\
   -timing\
    [list ${::IMEX::libVar}/mmmc/NangateOpenCellLibrary_worst_low_ccs.lib]
create_library_set -name typical\
   -timing\
    [list ${::IMEX::libVar}/mmmc/NangateOpenCellLibrary_typical_ccs.lib]
create_rc_corner -name default_rc_corner\
   -preRoute_res 1\
   -postRoute_res 1\
   -preRoute_cap 1\
   -postRoute_cap 1\
   -postRoute_xcap 1\
   -preRoute_clkres 0\
   -preRoute_clkcap 0
create_delay_corner -name fast\
   -library_set fast
create_delay_corner -name worst\
   -library_set worst
create_delay_corner -name typical\
   -library_set typical
create_constraint_mode -name synth\
   -sdc_files\
    [list ${::IMEX::libVar}/mmmc/MAC_512.sdc]
create_analysis_view -name fast -constraint_mode synth -delay_corner fast
create_analysis_view -name worst -constraint_mode synth -delay_corner worst
create_analysis_view -name typical -constraint_mode synth -delay_corner typical
set_analysis_view -setup [list worst] -hold [list fast]
