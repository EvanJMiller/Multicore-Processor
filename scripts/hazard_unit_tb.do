onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hazard_unit_tb/CLK
add wave -noupdate /hazard_unit_tb/nRST
add wave -noupdate /hazard_unit_tb/DUT/hzif/fetch_EN
add wave -noupdate /hazard_unit_tb/DUT/hzif/decode_EN
add wave -noupdate /hazard_unit_tb/DUT/hzif/exe_EN
add wave -noupdate /hazard_unit_tb/DUT/hzif/mem_EN
add wave -noupdate /hazard_unit_tb/DUT/hzif/fetch_NOP
add wave -noupdate /hazard_unit_tb/DUT/hzif/decode_NOP
add wave -noupdate /hazard_unit_tb/DUT/hzif/exe_NOP
add wave -noupdate /hazard_unit_tb/DUT/hzif/mem_NOP
add wave -noupdate /hazard_unit_tb/DUT/hzif/ihit
add wave -noupdate /hazard_unit_tb/DUT/hzif/dhit
add wave -noupdate /hazard_unit_tb/DUT/hzif/MemRd
add wave -noupdate /hazard_unit_tb/DUT/hzif/MemWr
add wave -noupdate /hazard_unit_tb/DUT/hzif/PCWE
add wave -noupdate /hazard_unit_tb/DUT/hzif/PCSrc
add wave -noupdate /hazard_unit_tb/DUT/hzif/rs
add wave -noupdate /hazard_unit_tb/DUT/hzif/rt
add wave -noupdate /hazard_unit_tb/DUT/hzif/exe_wsel
add wave -noupdate /hazard_unit_tb/DUT/hzif/mem_wsel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {1 us}
