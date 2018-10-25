// maped needs this
`include "request_unit_if.vh"

// mapped timing needs this, 1ns is too fast
`timescale 1 ns / 1 ns

// all types
`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"
import cpu_types_pkg::*;

module request_unit_tb;

  parameter PERIOD = 10;
  logic CLK = 0;
  logic nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  request_unit_if requif ();
  // test program
  test PROG (CLK, nRST, requif);
  // DUT
`ifndef MAPPED
  request_unit DUT (CLK, nRST, requif);
`else
  request_unit DUT (
    .\requif.MemWr = (requif.MemWr),
    .\requif.MemRd = (requif.MemRd),
    .\requif.ihit = (requif.ihit),
    .\requif.dhit = (requif.dhit),
    .\requif.iREN = (requif.iREN),
    .\requif.dREN = (requif.dREN),
    .\requif.dWEN = (requif.dWEN),
  );
`endif
endmodule

program test(
  input logic CLK,
  output logic nRST,
  request_unit_if.tb tb
);

  parameter PERIOD = 10;
  initial begin
  #(PERIOD)
  nRST = 1;
  #(PERIOD)
  nRST = 0;
  #(PERIOD)
  nRST = 1;
  #(PERIOD)

  tb.ihit = 1'b1;
  tb.dhit = 1'b0;
  tb.MemRd = 1'b1;
  tb.MemWr = 1'b0;
  #(PERIOD)
  if(tb.dREN == 1'b1 && tb.dWEN == 1'b0) begin
    $display("Test case passed");
  end else begin
    $display("Test case failed");
  end

  #(PERIOD)
  tb.ihit = 1'b0;
  tb.dhit = 1'b1;
  tb.MemRd = 1'b1;
  tb.MemWr = 1'b0;
  #(PERIOD)
  if(tb.dREN == 1'b0 && tb.dWEN == 1'b0) begin
    $display("Test case passed");
  end else begin
    $display("Test case failed");
  end

  #(PERIOD)
  tb.ihit = 1'b0;
  tb.dhit = 1'b0;
  tb.MemRd = 1'b1;
  tb.MemWr = 1'b0;
  #(PERIOD)
  if(tb.dREN == 1'b1 && tb.dWEN == 1'b0) begin
    $display("Test case passed");
  end else begin
    $display("Test case failed");
  end

  $finish;
  end
endprogram

