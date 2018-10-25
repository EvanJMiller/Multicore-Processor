`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  //import types
  import cpu_types_pkg::*;

  logic   negative, overflow, zero;
  word_t  porta, portb, out;
  aluop_t ALUOP;

  // alu ports
  modport alu (
    input  ALUOP, porta, portb,
    output negative, out, overflow, zero
  );

  // alu tb
  modport tb (
    input  negative, out, overflow, zero,
    output ALUOP, porta, portb
  );
endinterface

`endif //ALU_IF_VH

