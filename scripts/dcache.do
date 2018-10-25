onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/iwait
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/dwait
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/iREN
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/dREN
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/dWEN
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/iload
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/dload
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/dstore
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/iaddr
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/daddr
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/ccwait
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/ccinv
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/ccwrite
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/cctrans
add wave -noupdate -expand -group cif0 /dcache_tb/cif0/ccsnoopaddr
add wave -noupdate -group cif1 /dcache_tb/cif1/iwait
add wave -noupdate -group cif1 /dcache_tb/cif1/dwait
add wave -noupdate -group cif1 /dcache_tb/cif1/iREN
add wave -noupdate -group cif1 /dcache_tb/cif1/dREN
add wave -noupdate -group cif1 /dcache_tb/cif1/dWEN
add wave -noupdate -group cif1 /dcache_tb/cif1/iload
add wave -noupdate -group cif1 /dcache_tb/cif1/dload
add wave -noupdate -group cif1 /dcache_tb/cif1/dstore
add wave -noupdate -group cif1 /dcache_tb/cif1/iaddr
add wave -noupdate -group cif1 /dcache_tb/cif1/daddr
add wave -noupdate -group cif1 /dcache_tb/cif1/ccwait
add wave -noupdate -group cif1 /dcache_tb/cif1/ccinv
add wave -noupdate -group cif1 /dcache_tb/cif1/ccwrite
add wave -noupdate -group cif1 /dcache_tb/cif1/cctrans
add wave -noupdate -group cif1 /dcache_tb/cif1/ccsnoopaddr
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/dcache
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_dcache
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/mem_addr
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/snoop_addr
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/evict
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_evict
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/flush
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_flush
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/flush_idx
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_flush_idx
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/flush_frame
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_flush_frame
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/prev_addr
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_prev_addr
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/state
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_state
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/prev_state
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_prev_state
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/prev_ccwait
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/cache_hit
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_cache_hit
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/hit_count
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/next_hit_count
add wave -noupdate -expand -group dcache0 /dcache_tb/DC/ccstate
add wave -noupdate -group dcache1 /dcache_tb/DC1/dcache
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_dcache
add wave -noupdate -group dcache1 /dcache_tb/DC1/mem_addr
add wave -noupdate -group dcache1 /dcache_tb/DC1/snoop_addr
add wave -noupdate -group dcache1 /dcache_tb/DC1/evict
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_evict
add wave -noupdate -group dcache1 /dcache_tb/DC1/flush
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_flush
add wave -noupdate -group dcache1 /dcache_tb/DC1/flush_idx
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_flush_idx
add wave -noupdate -group dcache1 /dcache_tb/DC1/flush_frame
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_flush_frame
add wave -noupdate -group dcache1 /dcache_tb/DC1/prev_addr
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_prev_addr
add wave -noupdate -group dcache1 /dcache_tb/DC1/state
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_state
add wave -noupdate -group dcache1 /dcache_tb/DC1/prev_state
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_prev_state
add wave -noupdate -group dcache1 /dcache_tb/DC1/prev_ccwait
add wave -noupdate -group dcache1 /dcache_tb/DC1/cache_hit
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_cache_hit
add wave -noupdate -group dcache1 /dcache_tb/DC1/hit_count
add wave -noupdate -group dcache1 /dcache_tb/DC1/next_hit_count
add wave -noupdate -group dcache1 /dcache_tb/DC1/ccstate
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/halt
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/ihit
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/imemREN
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/imemload
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/imemaddr
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/dhit
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/datomic
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/dmemREN
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/dmemWEN
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/flushed
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/dmemload
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/dmemstore
add wave -noupdate -expand -group dcif0 /dcache_tb/dcif0/dmemaddr
add wave -noupdate -group dcif1 /dcache_tb/dcif1/halt
add wave -noupdate -group dcif1 /dcache_tb/dcif1/ihit
add wave -noupdate -group dcif1 /dcache_tb/dcif1/imemREN
add wave -noupdate -group dcif1 /dcache_tb/dcif1/imemload
add wave -noupdate -group dcif1 /dcache_tb/dcif1/imemaddr
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dhit
add wave -noupdate -group dcif1 /dcache_tb/dcif1/datomic
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemREN
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemWEN
add wave -noupdate -group dcif1 /dcache_tb/dcif1/flushed
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemload
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemstore
add wave -noupdate -group dcif1 /dcache_tb/dcif1/dmemaddr
add wave -noupdate -group {Memory Controller} /dcache_tb/MEM/rec
add wave -noupdate -group {Memory Controller} /dcache_tb/MEM/req
add wave -noupdate -group {Memory Controller} /dcache_tb/MEM/next_rec
add wave -noupdate -group {Memory Controller} /dcache_tb/MEM/next_req
add wave -noupdate -group {Memory Controller} /dcache_tb/MEM/state
add wave -noupdate -group {Memory Controller} /dcache_tb/MEM/next_state
add wave -noupdate -group RAM /dcache_tb/ramif/ramREN
add wave -noupdate -group RAM /dcache_tb/ramif/ramWEN
add wave -noupdate -group RAM /dcache_tb/ramif/ramaddr
add wave -noupdate -group RAM /dcache_tb/ramif/ramstore
add wave -noupdate -group RAM /dcache_tb/ramif/ramload
add wave -noupdate -group RAM /dcache_tb/ramif/ramstate
add wave -noupdate -group RAM /dcache_tb/ramif/memREN
add wave -noupdate -group RAM /dcache_tb/ramif/memWEN
add wave -noupdate -group RAM /dcache_tb/ramif/memaddr
add wave -noupdate -group RAM /dcache_tb/ramif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1141607 ps} 0}
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
WaveRestoreZoom {0 ps} {202 ns}
