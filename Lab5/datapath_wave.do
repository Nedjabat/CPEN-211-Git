onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/DUT/datapath_in
add wave -noupdate /datapath_tb/DUT/writenum
add wave -noupdate /datapath_tb/DUT/readnum
add wave -noupdate /datapath_tb/DUT/shift
add wave -noupdate /datapath_tb/DUT/ALUop
add wave -noupdate /datapath_tb/DUT/write
add wave -noupdate /datapath_tb/DUT/clk
add wave -noupdate /datapath_tb/DUT/loada
add wave -noupdate /datapath_tb/DUT/loadb
add wave -noupdate /datapath_tb/DUT/loadc
add wave -noupdate /datapath_tb/DUT/loads
add wave -noupdate /datapath_tb/DUT/asel
add wave -noupdate /datapath_tb/DUT/bsel
add wave -noupdate /datapath_tb/DUT/vsel
add wave -noupdate /datapath_tb/DUT/datapath_out
add wave -noupdate /datapath_tb/DUT/Z_out
add wave -noupdate /datapath_tb/DUT/data_in
add wave -noupdate /datapath_tb/DUT/data_out
add wave -noupdate /datapath_tb/DUT/Ain
add wave -noupdate /datapath_tb/DUT/Bin
add wave -noupdate /datapath_tb/DUT/out
add wave -noupdate /datapath_tb/DUT/next_out_a
add wave -noupdate /datapath_tb/DUT/next_out_b
add wave -noupdate /datapath_tb/DUT/next_datapath_out
add wave -noupdate /datapath_tb/DUT/sout
add wave -noupdate /datapath_tb/DUT/Z
add wave -noupdate /datapath_tb/DUT/next_out_z
add wave -noupdate /datapath_tb/DUT/in
add wave -noupdate /datapath_tb/DUT/a_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1334 ps}
