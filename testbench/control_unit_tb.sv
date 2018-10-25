// maped needs this
`include "control_unit_if.vh"

// mapped timing needs this, 1ns is too fast
`timescale 1 ns / 1 ns

// all types
`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"
import cpu_types_pkg::*;

module control_unit_tb;

  parameter PERIOD = 10;
  logic CLK = 0;
  logic nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  control_unit_if ctrluif ();
  // test program
  test PROG (CLK, nRST, ctrluif);
  // DUT
`ifndef MAPPED
  control_unit DUT (ctrluif);
`else
  control_unit DUT(
    .\ctrluif.op       = (ctrluif.op),
    .\ctrluif.func     = (ctrluif.func),
    .\ctrluif.ALUOp    = (ctrluif.ALUOp),
    .\ctrluif.ExtOp    = (ctrluif.ExtOp),
    .\ctrluif.RegDst   = (ctrluif.RegDst),
    .\ctrluif.RegWr    = (ctrluif.RegWr),
    .\ctrluif.ALUSrc   = (ctrluif.ALUSrc),
    .\ctrluif.MemtoReg = (ctrluif.MemtoReg),
    .\ctrluif.MemRd    = (ctrluif.MemRd),
    .\ctrluif.MemWr    = (ctrluif.MemWr),
    .\ctrluif.halt     = (ctrluif.halt),
    .\ctrluif.PCSrc    = (ctrluif.PCSrc),
    //.\ctrluif.jr       = (ctrluif.jr),
    .\ctrluif.shift    = (ctrluif.shift),
    .\ctrluif.branch   = (ctrluif.branch),
    //.\ctrluif.bne      = (ctrluif.bne),
    //.\ctrluif.lui      = (ctrluif.lui),
    //.\ctrluif.jump     = (ctrluif.jump),
    .\ctrluif.jal      = (ctrluif.jal)
  );
`endif
endmodule

program test(
  input logic CLK,
  output logic nRST,
  control_unit_if.tb tb
);

  parameter PERIOD = 10;
  initial begin
  #(PERIOD)
  tb.op = RTYPE;
  tb.func = ADD;
  #(PERIOD)
  if(tb.ALUOp == ALU_ADD && tb.RegWr == 1'b1) begin
    $display("Test case passed; ALUOp: %b RegWr: %b", tb.ALUOp, tb.RegWr);
  end else begin
    $display("Test case failed");
  end

  #(PERIOD)
  tb.op = RTYPE;
  tb.func = JR;
  #(PERIOD)
  if(tb.ALUOp == ALU_SLL && tb.RegWr == 1'b0) begin
    $display("Test case passed; ALUOp: %b RegWr: %b", tb.ALUOp, tb.RegWr);
  end else begin
    $display("Test case failed");
  end

  #(PERIOD)
  tb.op = RTYPE;
  tb.func = SRL;
  #(PERIOD)
  if(tb.ALUOp == ALU_SRL && tb.RegWr == 1'b1) begin
    $display("Test case passed; ALUOp: %b shift: %b", tb.ALUOp, tb.shift);
  end else begin
    $display("Test case failed");
  end

  #(PERIOD)
  tb.op = J;
  #(PERIOD)
  if(tb.PCSrc == 2'b11) begin
    $display("Test case passed; PCSrc: %b", tb.PCSrc);
  end else begin
    $display("Test case failed");
  end

  #(PERIOD)
  tb.op = BNE;
  #(PERIOD)
  if(tb.PCSrc == 2'b10 && tb.branch == 1'b0) begin
    $display("Test case passed; PCSrc: %b Branch: %b", tb.PCSrc, tb.branch);
  end else begin
    $display("Test case failed");
  end

  #(PERIOD)
  tb.op = BEQ;
  #(PERIOD)
  if(tb.PCSrc == 2'b00 && tb.branch == 1'b1) begin
    $display("Test case passed; PCSrc: %b Branch: %b", tb.PCSrc, tb.branch);
  end else begin
    $display("Test case failed");
  end

  $finish;
  end
endprogram
