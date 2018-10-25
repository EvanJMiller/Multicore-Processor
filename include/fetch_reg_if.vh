`ifndef FETCH_REG_IF_VH
`define FETCH_REG_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface fetch_reg_if;
  // import types
  import cpu_types_pkg::*;

  logic [31:0] fetch_imemload, decode_imemload;
  logic [31:0] fetch_pc_4, decode_pc_4;
  logic flush, EN;

  // fetch register ports
  modport fetchu (
    input  flush, EN,
    input  fetch_imemload, fetch_pc_4,
    output decode_imemload, decode_pc_4
  );


  // fetch register ports
  modport tb (
    output fetch_imemload, fetch_pc_4, flush, EN,
    input  decode_imemload, decode_pc_4
  );


endinterface

`endif // FETCH_UNIT_IF_VH
