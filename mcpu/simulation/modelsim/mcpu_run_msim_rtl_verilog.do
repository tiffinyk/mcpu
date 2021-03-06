transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/controlUnit.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/PC.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/PCAddr.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/Extend.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/RegFile.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/DataSelect_2.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/DataLate.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/mcpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/DataMemory.v}
vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu {C:/Users/ASUS/Desktop/mcpu_2/mcpu/InsMemory.v}

vlog -vlog01compat -work work +incdir+C:/Users/ASUS/Desktop/mcpu_2/mcpu/.. {C:/Users/ASUS/Desktop/mcpu_2/mcpu/../mcpu_tst.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  mcpu_tst

add wave *
view structure
view signals
run -all
