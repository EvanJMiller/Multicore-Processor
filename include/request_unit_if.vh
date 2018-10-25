`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic iREN, dREN, dWEN, MemWr, MemRd, ihit, dhit;

  // request unit ports
  modport requ (
    input MemWr, MemRd, ihit, dhit,
    output iREN, dREN, dWEN
  );

  // request unit tb
  modport tb (
    output MemWr, MemRd, ihit, dhit,
    input iREN, dREN, dWEN
  );
endinterface

`endif // REQUEST_UNIT_IF_VH
