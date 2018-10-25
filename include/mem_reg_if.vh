`ifndef MEMORY_REG_IF_VH
`define MEMORY_REG_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface mem_reg_if;
  // import types

  import cpu_types_pkg::*;

   opcode_t op_in, op_out;

  // data signals
  logic [31:0] mem_pc_4, mem_dmemload, mem_ex_out, mem_alu_out, mem_wsel;
  logic [31:0] wrb_pc_4, wrb_dmemload, wrb_ex_out, wrb_alu_out, wrb_wsel;

  // memory register control signals
  logic flush, EN;
  logic mem_halt, mem_RegWr, wrb_halt, wrb_RegWr;
  logic [1:0] mem_MemtoReg, wrb_MemtoReg;

  // memory register ports
  modport memu (
    input  op_in,flush, EN,
    input  mem_pc_4, mem_dmemload, mem_ex_out, mem_alu_out, mem_wsel,
    input  mem_halt, mem_RegWr, mem_MemtoReg,
    output op_out,wrb_halt, wrb_RegWr, wrb_MemtoReg,
    output wrb_pc_4, wrb_dmemload, wrb_ex_out, wrb_alu_out, wrb_wsel
  );


  // memory register ports
  modport tb (
    output op_out,flush, EN,
    output mem_pc_4, mem_dmemload, mem_ex_out, mem_alu_out, mem_wsel,
    output mem_halt, mem_RegWr, mem_MemtoReg,
    input  op_in,wrb_halt, wrb_RegWr, wrb_MemtoReg,
    input  wrb_pc_4, wrb_dmemload, wrb_ex_out, wrb_alu_out, wrb_wsel
  );

endinterface

`endif // MEMORY_UNIT_IF_VH
