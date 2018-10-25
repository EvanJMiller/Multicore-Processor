`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  opcode_t op;
  logic[5:0] func;
  aluop_t ALUOp;
  ex_t ExtOp;
  logic [1:0] MemtoReg;
  logic [1:0] PCSrc;
  logic RegDst, RegWr, ALUSrc, MemRd, MemWr, shift, jal, branch, halt;

  // control unit ports
  modport ctrlu (
    input  op, func,
    output ALUOp, ExtOp, RegDst, RegWr, ALUSrc, MemtoReg, MemRd, MemWr, shift, jal, branch, halt, PCSrc
  );

  // control unit testbench
  modport tb (
    output op, func,
    input  ALUOp, ExtOp, RegDst, RegWr, ALUSrc, MemtoReg, MemRd, MemWr, shift, jal, branch, halt, PCSrc
  );
endinterface

`endif // CONTROL_UNIT_IF_VH
