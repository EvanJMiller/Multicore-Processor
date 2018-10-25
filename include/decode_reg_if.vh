`ifndef DECODE_REG_IF_VH
`define DECODE_REG_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface decode_reg_if;
  // import types
  import cpu_types_pkg::*;
   opcode_t op_in, op_out;
   
  // data signals
  logic [31:0] decode_rdat1, decode_rdat2, decode_ex_out, decode_pc_4;
  logic [25:0] decode_jump_addr;
  logic [4:0] decode_shamt, decode_rs, decode_rt, decode_rd;

  logic [31:0] exe_rdat1, exe_rdat2, exe_ex_out, exe_pc_4;
  logic [25:0] exe_jump_addr;
  logic [4:0]  exe_shamt, exe_rs, exe_rt, exe_rd;

  // execute control signals
  aluop_t decode_ALUOp, exe_ALUOp;
  logic decode_jal, decode_RegDst, decode_shift, decode_ALUSrc;
  logic exe_jal, exe_RegDst, exe_shift, exe_ALUSrc;

  // memory control signals
  logic decode_MemWr, decode_MemRd, decode_branch, exe_MemWr, exe_MemRd,exe_branch;
  logic [1:0] decode_PCSrc, exe_PCSrc;

  // write back control signals
  logic decode_halt, decode_RegWr, exe_halt, exe_RegWr;
  logic [1:0] decode_MemtoReg, exe_MemtoReg;

  // register control
  logic flush, EN;

  // decode register ports
  modport decodeu (
    input  op_in,flush, EN,
    input  decode_rdat1, decode_rdat2, decode_ex_out, decode_pc_4, decode_jump_addr, decode_shamt, decode_rs, decode_rt, decode_rd,
    input  decode_jal, decode_RegDst, decode_ALUOp, decode_shift, decode_ALUSrc,
    input  decode_MemWr, decode_MemRd, decode_branch, decode_PCSrc,
    output op_out,exe_MemWr, exe_MemRd,exe_branch, exe_PCSrc,
    output exe_rdat1, exe_rdat2, exe_ex_out, exe_pc_4, exe_jump_addr, exe_shamt, exe_rs, exe_rt, exe_rd,
    output exe_jal, exe_RegDst, exe_ALUOp, exe_shift, exe_ALUSrc
  );

  // decode register ports
  modport tb (
    output flush, EN,
    output decode_rdat1, decode_rdat2, decode_ex_out, decode_pc_4, decode_jump_addr, decode_shamt, decode_rs, decode_rt, decode_rd,
    output decode_jal, decode_RegDst, decode_ALUOp, decode_shift, decode_ALUSrc,
    output op_in,decode_MemWr, decode_MemRd, decode_branch, decode_PCSrc,
    input  op_out,exe_MemWr, exe_MemRd,exe_branch, exe_PCSrc,
    input  exe_rdat1, exe_rdat2, exe_ex_out, exe_pc_4, exe_jump_addr, exe_shamt, exe_rs, exe_rt, exe_rd,
    input  exe_jal, exe_RegDst, exe_ALUOp, exe_shift, exe_ALUSrc
  );

endinterface

`endif // DECODE_UNIT_IF_VH

