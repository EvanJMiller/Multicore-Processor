onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group CCIF /memory_control_tb/CLK
add wave -noupdate -expand -group CCIF /memory_control_tb/nRST
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/iwait
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/dwait
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/dREN
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/dWEN
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/iload
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/dload
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/dstore
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/daddr
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ccwait
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ccinv
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ccwrite
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/cctrans
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ccsnoopaddr
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ramWEN
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ramREN
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ramstate
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ramaddr
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ramstore
add wave -noupdate -expand -group CCIF /memory_control_tb/MEM/ccif/ramload
add wave -noupdate -expand -group {Memory Control} /memory_control_tb/MEM/rec
add wave -noupdate -expand -group {Memory Control} /memory_control_tb/MEM/req
add wave -noupdate -expand -group {Memory Control} /memory_control_tb/MEM/next_rec
add wave -noupdate -expand -group {Memory Control} /memory_control_tb/MEM/next_req
add wave -noupdate -expand -group {Memory Control} /memory_control_tb/MEM/state
add wave -noupdate -expand -group {Memory Control} /memory_control_tb/MEM/next_state
add wave -noupdate -expand -group RAMIF /memory_control_tb/RAM/ramif/ramREN
add wave -noupdate -expand -group RAMIF /memory_control_tb/RAM/ramif/ramWEN
add wave -noupdate -expand -group RAMIF /memory_control_tb/RAM/ramif/ramaddr
add wave -noupdate -expand -group RAMIF /memory_control_tb/RAM/ramif/ramstore
add wave -noupdate -expand -group RAMIF /memory_control_tb/RAM/ramif/ramload
add wave -noupdate -expand -group RAMIF /memory_control_tb/RAM/ramif/ramstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7838 ps} 0}
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
WaveRestoreZoom {0 ps} {139712 ps}
