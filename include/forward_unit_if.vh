`ifndef FORWARD_UNIT_IF_VH
 `define FORWARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface forward_unit_if;

import cpu_types_pkg::*;

logic[4:0] ex_rsel1;
logic [4:0] ex_rsel2; //rsel from execute stage
word_t ex_rdat1;
word_t ex_rdat2; //rdat from the execute stage

logic[4:0] mem_wsel; //wsel from the memory stage
word_t mem_dat; //data in the memory stage

logic[4:0] wb_wsel; //wsel from the write back stage
word_t wb_dat; //data in the write back stage

logic mem_wen, wb_wen; //write enable for register file
logic memToReg; //memToreg in the mem stage

word_t rdat1_out, rdat2_out; //outputs

modport fu(
  input ex_rsel1, ex_rsel2, ex_rdat1, ex_rdat2, mem_wsel, mem_dat,
  wb_wsel, wb_dat, memToReg, mem_wen, wb_wen,
  output rdat1_out, rdat2_out
);

modport tb(
  input rdat1_out, rdat2_out,
  output ex_rsel1, ex_rsel2, ex_rdat1, ex_rdat2, mem_wsel, mem_dat,
  wb_wsel, wb_dat, mem_wen, wb_wen, memToReg

);

endinterface

`endif
