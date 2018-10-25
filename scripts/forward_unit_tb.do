onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /forward_unit_tb/CLK
add wave -noupdate /forward_unit_tb/nRST
add wave -noupdate /forward_unit_tb/fuif/ex_rsel1
add wave -noupdate /forward_unit_tb/fuif/ex_rsel2
add wave -noupdate /forward_unit_tb/fuif/ex_rdat1
add wave -noupdate /forward_unit_tb/fuif/ex_rdat2
add wave -noupdate /forward_unit_tb/fuif/mem_wsel
add wave -noupdate /forward_unit_tb/fuif/mem_dat
add wave -noupdate /forward_unit_tb/fuif/wb_wsel
add wave -noupdate /forward_unit_tb/fuif/wb_dat
add wave -noupdate /forward_unit_tb/fuif/mem_wen
add wave -noupdate /forward_unit_tb/fuif/wb_wen
add wave -noupdate /forward_unit_tb/fuif/memToReg
add wave -noupdate /forward_unit_tb/fuif/rdat1_out
add wave -noupdate /forward_unit_tb/fuif/rdat2_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {18 ns}
