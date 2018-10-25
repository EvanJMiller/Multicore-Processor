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
  datapath_cache_if dcif0 ();
  datapath_cache_if dcif1 ();

  caches_if   cif0 ();
  caches_if   cif1 ();
  cache_control_if ccif (cif0, cif1);
  cpu_ram_if ramif ();

  // test program
  test PROG (CLK, nRST, dcif0, dcif1, cif0, cif1);
  // DUT
  dcache DC (CLK, nRST, dcif0, cif0);
  dcache DC1 (CLK, nRST, dcif1, cif1);
  memory_control MEM(CLK, nRST, ccif);
  ram RAM(CLK, nRST, ramif);

  assign ramif.ramaddr = ccif.ramaddr;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN = ccif.ramREN;
  assign ramif.ramWEN = ccif.ramWEN;
  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload = ramif.ramload;

endmodule

program test(input logic CLK,
             output logic nRST,
             datapath_cache_if dcif0,
             datapath_cache_if dcif1,
             caches_if cif0,
             caches_if cif1);

  parameter PERIOD = 10;
  initial begin
  nRST = 0;
  @(negedge CLK);
  nRST = 1;

  // Load first block
  #(PERIOD)
  dcif0.dmemaddr = 32'h0300;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  //@(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  if(DC.dcache[0].frame_1.data[0] == 32'h40) begin
    $display("Test case 1 - Loading first block - word 0  passed!");
  end
  if(DC.dcache[0].frame_1.data[1] == 32'h5a) begin
    $display("Test case 2 - Loading first block - word 1  passed!");
  end
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  //#(PERIOD)
  // Check hit for first block that was loaded
  dcif0.dmemaddr = 32'h0304;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  #(PERIOD)
  if(DC.hit_count == 32'd1) begin
    $display("Test case 3 - Checking for cache hit with read passed!");
  end
  // Write to block that was previously loaded
  dcif0.dmemaddr = 32'h0304;
  dcif0.dmemREN = 1'b0;
  dcif0.dmemWEN = 1'b1;
  dcif0.dmemstore  = 32'hBEEF;
  dcif0.halt   = 1'b0;
  #(PERIOD)
  if(DC.hit_count == 32'd2) begin
    $display("Test case 4 - Checking for cache hit with write passed!");
  end
  if(DC.dcache[0].frame_1.dirty == 1'b1) begin
    $display("Test case 5 - Checking index 0 dirty bit is set passed!");
  end
  // Fill cache with loads
  // Frame1
  dcif0.dmemaddr = 32'h0308;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0310;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0318;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0320;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0328;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0330;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0338;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  // Frame 2
  dcif0.dmemaddr = 32'h0340;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0348;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0350;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0358;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0360;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0368;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0370;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  dcif0.dmemaddr = 32'h0378;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)

  // Test for eviction and write back
  dcif0.dmemaddr = 32'h0380;
  dcif0.dmemREN = 1'b1;
  dcif0.dmemWEN = 1'b0;
  dcif0.halt   = 1'b0;
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
  @(negedge cif0.dwait);
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
  dcif0.dmemaddr = 32'h0300;
  dcif0.dmemREN = 1'b0;
  dcif0.dmemWEN = 1'b1;
  dcif0.dmemstore  = 32'hDEAD;
  dcif0.halt   = 1'b0;
  #(PERIOD)
  dcif0.dmemaddr = 32'h0318;
  dcif0.dmemREN = 1'b0;
  dcif0.dmemWEN = 1'b1;
  dcif0.dmemstore  = 32'hDEAD;
  dcif0.halt   = 1'b0;
  #(PERIOD)
  dcif0.dmemaddr = 32'h0330;
  dcif0.dmemREN = 1'b0;
  dcif0.dmemWEN = 1'b1;
  dcif0.dmemstore  = 32'hDEAD;
  dcif0.halt   = 1'b0;
  #(PERIOD)
  dcif0.dmemaddr = 32'h0348;
  dcif0.dmemREN = 1'b0;
  dcif0.dmemWEN = 1'b1;
  dcif0.dmemstore  = 32'hDEAD;
  dcif0.halt   = 1'b0;
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)


  // Test cache to cache transfer
  dcif1.dmemaddr = 32'h0380;
  dcif1.dmemREN = 1'b1;
  dcif1.dmemWEN = 1'b0;
  dcif1.halt   = 1'b0;
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  if(DC1.dcache[0].frame_1.data[0] == 32'h0003 && DC1.dcache[0].frame_1.data[1] == 32'h0030) begin
    $display("Test case 9 - Cache to cache transfer passed!");
  end

  #(PERIOD)
  #(PERIOD)

  // Test invalidation of cache
  dcif1.dmemaddr = 32'h0348;
  dcif1.dmemREN = 1'b0;
  dcif1.dmemWEN = 1'b1;
  dcif1.dmemstore = 32'hAAAA;
  dcif1.halt   = 1'b0;


  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)

  // Test flush
  dcif0.halt = 1'b1;
  dcif1.halt = 1'b1;
  @(negedge cif0.dwait);
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  #(PERIOD)
  @(posedge CLK)
  @(posedge CLK)
  if(dcif0.flushed == 1'b1) begin
    $display("Test case 9 - Flushed set after flushing cache passed");
  end
  /*
  if(cif0.dstore == 32'd6 && cif0.daddr == 32'h3100) begin
    $display("Test case 10 - Testing number of dhits written to address 0x3100 passed!");
  end
  */
  $finish;
  end
endprogram
