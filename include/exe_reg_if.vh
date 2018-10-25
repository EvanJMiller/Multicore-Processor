`ifndef EXE_REG_IF_VH
`define EXE_REG_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface exe_reg_if;
  // import types
  import cpu_types_pkg::*;
  opcode_t op_in, op_out;
   
  // data signals
  logic [27:0] exe_jump_addr, mem_jump_addr;
  logic [31:0] exe_pc_4, exe_branch_addr, exe_rdat1, exe_ex_out, exe_alu_out, exe_rdat2, exe_wsel;
  logic [31:0] mem_pc_4, mem_branch_addr, mem_rdat1, mem_ex_out, mem_alu_out, mem_rdat2, mem_wsel;

  // memory control signals
  logic exe_MemWr, exe_MemRd, exe_branch, exe_zero, mem_MemWr, mem_MemRd, mem_branch, mem_zero;
  logic [1:0] exe_PCSrc, mem_PCSrc;

  // write back control signals
  logic exe_halt, exe_RegWr, mem_halt, mem_RegWr;
  logic [1:0] exe_MemtoReg, mem_MemtoReg;

  // register control
  logic flush, EN;

  // execute register ports
  modport exeu (
    input  op_in,flush, EN,
    input  exe_jump_addr, exe_pc_4, exe_branch_addr, exe_rdat1, exe_ex_out, exe_alu_out, exe_rdat2, exe_wsel,
    input  exe_MemWr, exe_MemRd, exe_branch, exe_zero, exe_PCSrc,
    input  exe_halt, exe_RegWr, exe_MemtoReg,
    output op_out,mem_halt, mem_RegWr, mem_MemtoReg,
    output mem_MemWr, mem_MemRd, mem_branch, mem_zero, mem_PCSrc,
    output mem_jump_addr, mem_pc_4, mem_branch_addr, mem_rdat1, mem_ex_out, mem_alu_out, mem_rdat2, mem_wsel
  );


  // execute register ports
  modport tb (
    
    output flush, EN,
    output exe_jump_addr, exe_pc_4, exe_branch_addr, exe_rdat1, exe_ex_out, exe_alu_out, exe_rdat2, exe_wsel,
    output exe_MemWr, exe_MemRd, exe_branch, exe_zero, exe_PCSrc,
    output op_in, exe_halt, exe_RegWr, exe_MemtoReg,
    input  op_out, mem_halt, mem_RegWr, mem_MemtoReg,
    input  mem_MemWr, mem_MemRd, mem_branch, mem_zero, mem_PCSrc,
    input  mem_jump_addr, mem_pc_4, mem_branch_addr, mem_rdat1, mem_ex_out, mem_alu_out, mem_rdat2, mem_wsel
  );

endinterface

`endif // EXE_UNIT_IF_VH
