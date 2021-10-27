onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab3_top_tb/sim_SW
add wave -noupdate /lab3_top_tb/sim_KEY
add wave -noupdate /lab3_top_tb/sim_HEX0
add wave -noupdate /lab3_top_tb/sim_HEX1
add wave -noupdate /lab3_top_tb/sim_HEX2
add wave -noupdate /lab3_top_tb/sim_HEX3
add wave -noupdate /lab3_top_tb/sim_HEX4
add wave -noupdate /lab3_top_tb/sim_HEX5
add wave -noupdate /lab3_top_tb/err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16 ps} 0}
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
WaveRestoreZoom {0 ps} {78 ps}
