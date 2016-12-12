set_global_assignment -entity "const_mult" -library "lib_const_mult" -name IP_TOOL_NAME "altera_mult_add"
set_global_assignment -entity "const_mult" -library "lib_const_mult" -name IP_TOOL_VERSION "16.0"
set_global_assignment -entity "const_mult" -library "lib_const_mult" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_const_mult" -name SPD_FILE [file join $::quartus(sip_path) "const_mult.spd"]

set_global_assignment -library "lib_const_mult" -name MISC_FILE [file join $::quartus(sip_path) "const_mult_sim/const_mult.v"]
