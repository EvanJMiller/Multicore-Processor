`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;

  // control signals
  logic fetch_EN, decode_EN, exe_EN, mem_EN;
  logic fetch_NOP, decode_NOP, exe_NOP, mem_NOP;
  logic ihit, dhit, MemRd, MemWr, PCWE;
  logic [1:0] PCSrc;
  regbits_t rs, rt, exe_wsel, mem_wsel;

  modport hazard(
    input  ihit, dhit, MemRd, MemWr, PCSrc,
    input  rs, rt, exe_wsel, mem_wsel,
    output fetch_EN, decode_EN, exe_EN, mem_EN,
    output fetch_NOP, decode_NOP, exe_NOP, mem_NOP,
    output PCWE
  );

  modport tb(
    output ihit, dhit, MemRd, MemWr, PCSrc,
    output rs, rt, exe_wsel, mem_wsel,
    input  fetch_EN, decode_EN, exe_EN, mem_EN,
    input  fetch_NOP, decode_NOP, exe_NOP, mem_NOP,
    input  PCWE

  );

endinterface

`endif // HAZARD_UNIT_IF_VH
