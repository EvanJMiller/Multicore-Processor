// maped needs this
`include "cache_control_if.vh"
`include "caches_if.vh"

// mapped timing needs this, 1ns is too fast
`timescale 1 ns / 1 ns

// all types
`include "cpu_types_pkg.vh"
`include "cpu_ram_if.vh"
import cpu_types_pkg::*;

module memory_control_tb;

  parameter PERIOD = 10;
  logic CLK = 0;
  logic nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  caches_if cif0 ();
  caches_if cif1 ();
  cache_control_if ccif (cif0, cif1);
  cpu_ram_if ramif ();

  // test program
  test PROG(CLK, nRST, ccif);

  // DUT
  memory_control MEM(CLK, nRST, ccif);
  ram RAM(CLK, nRST, ramif);

  // Connect bus controller to ram
  assign ramif.ramaddr  = ccif.ramaddr;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN   = ccif.ramREN;
  assign ramif.ramWEN   = ccif.ramWEN;
  assign ccif.ramstate  = ramif.ramstate;
  assign ccif.ramload   = ramif.ramload;

endmodule


program test(
  input logic CLK,
  output logic nRST,
  cache_control_if ccif
);

  import cpu_types_pkg::*;

  parameter PERIOD = 10;
  initial begin
  nRST = 1'b0;
  @(negedge CLK);
  nRST = 1'b1;
  #(PERIOD)

  // Test case 1 - Cache0 Reading, transitioning from I->S
  $display("Beginning test case 1...");
  ccif.cif0.dREN    = 1'b1;
  ccif.cif0.dWEN    = 1'b0;
  ccif.cif1.dREN    = 1'b0;
  ccif.cif1.dWEN    = 1'b0;
  ccif.cif0.ccwrite = 1'b0;
  ccif.cif1.ccwrite = 1'b0;
  ccif.cif0.cctrans = 1'b1;
  ccif.cif1.cctrans = 1'b0;
  ccif.cif0.daddr   = 32'h0300;
  ccif.cif0.dstore  = 32'h0000ABCD;
  ccif.cif1.daddr   = '0;
  ccif.cif1.dstore  = '0;

  // Transition to ARBITRATE
  #(PERIOD)
  if(MEM.req == 1'b0 && MEM.rec == 1'b1) begin
    $display("Requester and receiver properly set!");
  end
  else begin
    $display("Requester and receiver not properly set!");
  end

  // Transition to SNOOP
  ccif.cif1.cctrans = 1'b1;
  #(PERIOD)
  if(ccif.cif1.ccwait == 1'b1 && ccif.cif1.ccsnoopaddr == 32'h0300) begin
    $display("Receiving cache waiting and snoop addr set correctly!");
  end
  else begin
    $display("Receiving cache waiting and snoop addr not set correctly!");
  end

  // Transistion to READ1
  #(PERIOD)
  if(ramif.ramaddr == ccif.cif0.daddr && ramif.ramREN == 1'b1) begin
    $display("RAM addr to read set correctly!");
  end
  else begin
    $display("RAM addr to read set incorrectly!");
  end
  @(ramif.ramstate == ACCESS);
  if(ccif.cif0.dload == ramif.ramload) begin
    $display("Correct data sent from RAM to cache!");
  end
  else begin
    $display("Incorrect data sent from RAM to cache!");
  end

  // Transition to READ2
  #(PERIOD)
  ccif.cif0.daddr = ccif.cif0.daddr + 32'd4;
  #(PERIOD)
  //$display("RAM address: %h", ramif.ramaddr);
  //$display("D   address: %h", ccif.cif0.daddr);
  if((ramif.ramaddr == ccif.cif0.daddr) && ramif.ramREN == 1'b1) begin
    $display("RAM addr to read set correctly!");
  end
  else begin
    $display("RAM addr to read set incorrectly!");
  end
  if(ccif.cif0.dload == ramif.ramload) begin
    $display("Correct data sent from RAM to cache!");
  end
  else begin
    $display("Incorrect data sent from RAM to cache!");
  end
  if(ccif.cif1.ccinv == 1'b0 ) begin
    $display("Invalidate set correctly in read!");
  end
  else begin
    $display("Invalidate set incorrectly in read!");
  end
  @(ramif.ramstate == ACCESS);
  /*
  $display("RAM data: %h", ramif.ramload);
  $display("D   data: %h", ccif.cif0.dload);
  if(ccif.cif0.dload == ramif.ramload) begin
    $display("Correct data sent from RAM to cache!");
  end
  else begin
    $display("Incorrect data sent from RAM to cache!");
  end*/
  // Go back to IDLE
  #(PERIOD)
  // Test case 2 - cache0 reading, transitioning S->M
  $display("Beginning test case 2...");
  ccif.cif0.dREN    = 1'b1;
  ccif.cif0.dWEN    = 1'b0;
  ccif.cif0.ccwrite = 1'b1;
  ccif.cif1.ccwrite = 1'b1;
  ccif.cif0.cctrans = 1'b1;
  ccif.cif1.cctrans = 1'b0;
  ccif.cif0.daddr   = 32'h00000090;
  ccif.cif0.dstore  = 32'h0000DCBA;
  ccif.cif1.daddr   = 32'h00000090;
  ccif.cif1.dstore  = 32'h0000DEAD;

  // Transition to ARBITRATE
  #(PERIOD)
  if(MEM.req == 1'b0 && MEM.rec == 1'b1) begin
    $display("Requester and receiver properly set!");
  end
  else begin
    $display("Requester and receiver not properly set!");
  end

  // Transition to SNOOP
  #(PERIOD)
  if(ccif.cif1.ccwait == 1'b1 && ccif.cif1.ccsnoopaddr == 32'h0090) begin
    $display("Receiving cache waiting and snoop addr set correctly!");
  end
  else begin
    $display("Receiving cache waiting and snoop addr not set correctly!");
  end

  // Transistion to WRITE1
  ccif.cif1.cctrans = 1'b1;
  #(PERIOD)
  if(ramif.ramaddr == ccif.cif1.daddr && ramif.ramWEN == 1'b1) begin
    $display("RAM addr to write set correctly!");
  end
  else begin
    $display("RAM addr to write set incorrectly!");
  end
  @(ramif.ramstate == ACCESS);
  if(ccif.cif1.dstore == ramif.ramstore) begin
    $display("Correct data written to RAM from cache!");
  end
  else begin
    $display("Incorrect data written to RAM from cache!");
  end
  if(ccif.cif0.dwait == 0 & ccif.cif0.dload == ccif.cif1.dstore) begin
    $display("Correct data sent from cache to other cache after writing back!");
  end
  else begin
    $display("Inorrect data sent from cache to other cache after writing back!");
  end

  // Transition to WRITE2
  #(PERIOD)
  ccif.cif1.dstore = 32'h0000BEEF;
  ccif.cif1.daddr = ccif.cif1.daddr + 32'd4;
  #(PERIOD)
  if((ramif.ramaddr == ccif.cif1.daddr) && ramif.ramWEN == 1'b1) begin
    $display("RAM addr to write set correctly!");
  end
  else begin
    $display("RAM addr to write set incorrectly!");
  end
  if(ccif.cif1.dstore == ramif.ramstore) begin
    $display("Correct data written to RAM from cache!");
  end
  else begin
    $display("Incorrect data written to RAM from cache!");
  end
  if(ccif.cif0.dwait == 0 & ccif.cif0.dload == ccif.cif1.dstore) begin
    $display("Correct data sent from cache to other cache after writing back!");
  end
  else begin
    $display("Inorrect data sent from cache to other cache after writing back!");
  end
  if(ccif.cif1.ccinv == 1'b1 ) begin
    $display("Invalidate set correctly in write!");
  end
  else begin
    $display("Invalidate set incorrectly in write!");
  end
  @(ramif.ramstate == ACCESS);
  /*
  if(ccif.cif1.dstore == ramif.ramstore) begin
    $display("Correct data written to RAM from cache!");
  end
  else begin
    $display("Incorrect data written to RAM from cache!");
  end
  if(ccif.cif0.dwait == 0 & ccif.cif0.dload == ccif.cif1.dstore) begin
    $display("Correct data sent from cache to other cache after writing back!");
  end
  else begin
    $display("Inorrect data sent from cache to other cache after writing back!");
  end
  */
  // Go back to IDLE
  #(PERIOD)
  // Test case 3 - Testing writeback after eviction
  $display("Beginning test case 3...");
  ccif.cif0.dREN    = 1'b0;
  ccif.cif0.dWEN    = 1'b1;
  ccif.cif0.cctrans = 1'b1;
  ccif.cif1.cctrans = 1'b1;
  ccif.cif0.daddr   = 32'h00000070;
  ccif.cif0.dstore  = 32'h0000DCBB;
  ccif.cif1.daddr   = 32'h00000030;
  ccif.cif1.dstore  = 32'h0000DEDD;

  // Transition to ARBITRATE
  #(PERIOD)
  if(MEM.req == 1'b0 && MEM.rec == 1'b1) begin
    $display("Requester and receiver properly set!");
  end
  else begin
    $display("Requester and receiver not properly set!");
  end

  // Transistion to WB1
  //#(PERIOD)
  if(ramif.ramstore == ccif.cif0.dstore && ramif.ramaddr == ccif.cif0.daddr) begin
    $display("Correct data and address sent to RAM!");
  end
  else begin
    $display("Incorrect data or address sent to RAM!");
  end
  //ccif.cif0.dstore = 32'h0000DDDD;
  //ccif.cif0.daddr  = ccif.cif0.daddr + 32'd4;
  @(ramif.ramstate == ACCESS);

  // Transition to WB2
  #(PERIOD)
  ccif.cif0.dstore = 32'h0000DDDD;
  ccif.cif0.daddr  = ccif.cif0.daddr + 32'd4;
  #(PERIOD)
  if(ramif.ramstore == ccif.cif0.dstore && ramif.ramaddr == ccif.cif0.daddr) begin
    $display("Correct data and address sent to RAM!");
  end
  else begin
    $display("Incorrect data or address sent to RAM!");
  end
  @(ramif.ramstate == ACCESS)
  // Go back to IDLE

  // Test case 4 -


  $finish;

end

endprogram
