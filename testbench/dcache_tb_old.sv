// maped needs this
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// mapped timing needs this, 1ns is too fast
`timescale 1 ns / 1 ns

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module dcache_tb;

  parameter PERIOD = 10;
  logic CLK = 0;
  logic nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  datapath_cache_if dcif ();
  caches_if   cif0 ();
  caches_if   cif1 ();
  cache_control_if ccif (cif0, cif1);
  cpu_ram_if ramif ();

  // test program
  test PROG (CLK, nRST, dcif, cif0);
  // DUT
  dcache DC (CLK, nRST, dcif, cif0);
  memory_control MEM(CLK, nRST, ccif);
  ram RAM(CLK, nRST, ramif);

  assign ramif.ramaddr = cif0.daddr;
  assign ramif.ramstore = cif0.dstore;
  assign ramif.ramREN = ccif.dREN;
  assign ramif.ramWEN = ccif.dWEN;
  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;

endmodule

program test(input logic CLK,
             output logic nRST,
             datapath_cache_if dcif,
             caches_if cif);

  parameter PERIOD = 10;
  initial begin
  nRST = 0;
  @(negedge CLK);
  nRST = 1;

  // Load first block
  #(PERIOD)
  dcif.dmemaddr = 32'h0300;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  if(DC.dcache[0].frame_1.data[0] == 32'h40) begin
    $display("Test case 1 - Loading first block - word 0  passed!");
  end
  if(DC.dcache[0].frame_1.data[1] == 32'h5a) begin
    $display("Test case 2 - Loading first block - word 1  passed!");
  end
  // Check hit for first block that was loaded
  dcif.dmemaddr = 32'h0304;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  #(PERIOD)
  if(DC.hit_count == 32'd1) begin
    $display("Test case 3 - Checking for cache hit with read passed!");
  end
  // Write to block that was previously loaded
  dcif.dmemaddr = 32'h0304;
  dcif.dmemREN = 1'b0;
  dcif.dmemWEN = 1'b1;
  dcif.dmemstore  = 32'hBEEF;
  dcif.halt   = 1'b0;
  #(PERIOD)
  if(DC.hit_count == 32'd2) begin
    $display("Test case 4 - Checking for cache hit with write passed!");
  end
  if(DC.dcache[0].frame_1.dirty == 1'b1) begin
    $display("Test case 5 - Checking index 0 dirty bit is set passed!");
  end
  // Fill cache with loads
  // Frame1
  dcif.dmemaddr = 32'h0308;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0310;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0318;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0320;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0328;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0330;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0338;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  // Frame 2
  dcif.dmemaddr = 32'h0340;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0348;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0350;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0358;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0360;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0368;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0370;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif.dmemaddr = 32'h0378;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)

  // Test for eviction and write back
  dcif.dmemaddr = 32'h0380;
  dcif.dmemREN = 1'b1;
  dcif.dmemWEN = 1'b0;
  dcif.halt   = 1'b0;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  if(DC.dcache[0].frame_1.dirty == 1'b0) begin
    $display("Test case 6 - Checking for dirty get unset after writeback passed!");
  end
  if(DC.dcache[0].frame_1.data[0] == 32'h3) begin
    $display("Test case 7 - Checking for eviction and updated data[0] passed!");
  end
  if(DC.dcache[0].frame_1.data[1] == 32'h30) begin
    $display("Test case 8 - Checking for eviction and updated data[1] passed!");
  end

  // Make some frames dirty
  dcif.dmemaddr = 32'h0300;
  dcif.dmemREN = 1'b0;
  dcif.dmemWEN = 1'b1;
  dcif.dmemstore  = 32'hDEAD;
  dcif.halt   = 1'b0;
  #(PERIOD)
  dcif.dmemaddr = 32'h0318;
  dcif.dmemREN = 1'b0;
  dcif.dmemWEN = 1'b1;
  dcif.dmemstore  = 32'hDEAD;
  dcif.halt   = 1'b0;
  #(PERIOD)
  dcif.dmemaddr = 32'h0330;
  dcif.dmemREN = 1'b0;
  dcif.dmemWEN = 1'b1;
  dcif.dmemstore  = 32'hDEAD;
  dcif.halt   = 1'b0;
  #(PERIOD)
  dcif.dmemaddr = 32'h0348;
  dcif.dmemREN = 1'b0;
  dcif.dmemWEN = 1'b1;
  dcif.dmemstore  = 32'hDEAD;
  dcif.halt   = 1'b0;
  #(PERIOD)
  #(PERIOD)

  // Test flush
  dcif.halt = 1'b1;
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  @(negedge ccif.dwait);
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  if(dcif.flushed == 1'b1) begin
    $display("Test case 9 - Flushed set after flushing cache passed");
  end
  if(cif.dstore == 32'd6 && cif.daddr == 32'h3100) begin
    $display("Test case 10 - Testing number of dhits written to address 0x3100 passed!");
  end
  $finish;
  end
endprogram
