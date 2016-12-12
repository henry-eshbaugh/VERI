transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+H:/VERI-git/VERI/part_2/ex7 {H:/VERI-git/VERI/part_2/ex7/lfsr7.v}

