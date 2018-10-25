onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group {Instruction OP [DP0, DP1]} /system_tb/DUT/CPU/DP0/erif/op_out
add wave -noupdate -expand -group {Instruction OP [DP0, DP1]} /system_tb/DUT/CPU/DP1/erif/op_out
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/iwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/dwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/iREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/dREN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/dWEN
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/iload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/dload
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/dstore
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/iaddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/daddr
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccwait
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccinv
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccwrite
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/cctrans
add wave -noupdate -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccsnoopaddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/iwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/dwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/iREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/dREN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/dWEN
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/iload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/dload
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/dstore
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/iaddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/daddr
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccwait
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccinv
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccwrite
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/cctrans
add wave -noupdate -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccsnoopaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group dcache0 -expand -subitemconfig {{/system_tb/DUT/CPU/CM0/DCACHE/dcache[0]} -expand} /system_tb/DUT/CPU/CM0/DCACHE/dcache
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_dcache
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/mem_addr
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/snoop_addr
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/evict
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_evict
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_idx
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush_idx
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/flush_frame
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_flush_frame
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/prev_addr
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_prev_addr
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/prev_state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_prev_state
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/prev_ccwait
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/cache_hit
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_cache_hit
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/hit_count
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/next_hit_count
add wave -noupdate -group dcache0 /system_tb/DUT/CPU/CM0/DCACHE/ccstate
add wave -noupdate -group dcache1 -expand -subitemconfig {{/system_tb/DUT/CPU/CM1/DCACHE/dcache[0]} -expand} /system_tb/DUT/CPU/CM1/DCACHE/dcache
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_dcache
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/mem_addr
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/snoop_addr
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/evict
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_evict
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_idx
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush_idx
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/flush_frame
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_flush_frame
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/prev_addr
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_prev_addr
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/prev_state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_prev_state
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/prev_ccwait
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/cache_hit
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_cache_hit
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/hit_count
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/next_hit_count
add wave -noupdate -group dcache1 /system_tb/DUT/CPU/CM1/DCACHE/ccstate
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/rec
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/req
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/next_rec
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/next_req
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/state
add wave -noupdate -group {memory controller} /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -group {DP0 Registers} /system_tb/DUT/CPU/DP0/REG/registers
add wave -noupdate -group {DP1 Registers} -expand /system_tb/DUT/CPU/DP1/REG/registers
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/op_in
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/op_out
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_rdat1
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_rdat2
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_ex_out
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_pc_4
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_jump_addr
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_shamt
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_rs
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_rt
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_rd
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_rdat1
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_rdat2
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_ex_out
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_pc_4
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_jump_addr
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_shamt
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_rs
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_rt
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_rd
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_ALUOp
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_ALUOp
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_jal
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_RegDst
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_shift
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_ALUSrc
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_jal
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_RegDst
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_shift
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_ALUSrc
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_MemWr
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_MemRd
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_branch
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_MemWr
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_MemRd
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_branch
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_PCSrc
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_PCSrc
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_halt
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_RegWr
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_halt
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_RegWr
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/decode_MemtoReg
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/exe_MemtoReg
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/flush
add wave -noupdate -group {Decode Reg 0} /system_tb/DUT/CPU/DP0/drif/EN
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/op_in
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/op_out
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_jump_addr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_jump_addr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_pc_4
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_branch_addr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_rdat1
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_ex_out
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_alu_out
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_rdat2
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_wsel
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_pc_4
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_branch_addr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_rdat1
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_ex_out
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_alu_out
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_rdat2
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_wsel
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_MemWr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_MemRd
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_branch
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_zero
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_MemWr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_MemRd
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_branch
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_zero
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_PCSrc
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_PCSrc
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_halt
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_RegWr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_halt
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_RegWr
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/exe_MemtoReg
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/mem_MemtoReg
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/flush
add wave -noupdate -group {Exe Reg 0} /system_tb/DUT/CPU/DP0/erif/EN
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/op_in
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/op_out
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_pc_4
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_dmemload
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_ex_out
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_alu_out
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_wsel
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_pc_4
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_dmemload
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_ex_out
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_alu_out
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_wsel
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/flush
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/EN
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_halt
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_RegWr
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_halt
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_RegWr
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/mem_MemtoReg
add wave -noupdate -group {Mem Reg 0} /system_tb/DUT/CPU/DP0/mrif/wrb_MemtoReg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {927162 ps} 0}
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
WaveRestoreZoom {0 ps} {3088 ns}
