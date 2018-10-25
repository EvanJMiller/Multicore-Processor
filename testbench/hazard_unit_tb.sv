// maped needs this
`include "hazard_unit_if.vh"

// mapped timing needs this, 1ns is too fast
`timescale 1 ns / 1 ns

// all types
`include "cpu_types_pkg.vh"
`include "hazard_unit_if.vh"
import cpu_types_pkg::*;

module hazard_unit_tb;

  parameter PERIOD = 10;
  logic CLK = 0;
  logic nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interfaces
  hazard_unit_if hzif ();
  // test program
  test PROG (CLK, nRST, hzif);
  // DUT
  hazard_unit DUT (hzif);

endmodule

program test(input logic CLK,
             output logic nRST,
             hazard_unit_if.tb hzif);

  parameter PERIOD = 10;
  initial begin
  hzif.rs = '0;
  hzif.rt = '0;
  hzif.exe_wsel = '0;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = '0;


//Wsel is 0

  #(PERIOD)
  hzif.rs = 5'h0;
  hzif.rt = '0;
  hzif.exe_wsel = 5'h0;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = '0;

//rs matches wsel
#(PERIOD)

  hzif.rs = 5'h5;
  hzif.rt = '0;
  hzif.exe_wsel = 5'h5;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = '0;

//rs matches mem_wsel
#(PERIOD)

  hzif.rs = 5'h5;
  hzif.rt = '0;
  hzif.exe_wsel = 5'h0;
  hzif.mem_wsel = 5'h5;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = '0;


//rt matches exe_wsel
#(PERIOD)

  hzif.rs = 5'h0;
  hzif.rt = 5'h5;
  hzif.exe_wsel = 5'h5;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = '0;


//rt match mem_wsel
#(PERIOD)

  hzif.rs = 5'h0;
  hzif.rt = 5'h5;
  hzif.exe_wsel = 5'h0;
  hzif.mem_wsel = 5'h5;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = '0;

//matching rs and exe_wsel with a load/store
#(PERIOD)
  hzif.rs = 5'h5;
  hzif.rt = '0;
  hzif.exe_wsel = 5'h5;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = 1'b1;
  hzif.MemWr = 1'b1;
  hzif.PCSrc = '0;

//jump
#(PERIOD)

  hzif.rs = 5'h0;
  hzif.rt = '0;
  hzif.exe_wsel = 5'h0;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = 2'h3;
//branch

#(PERIOD)

  hzif.rs = 5'h5;
  hzif.rt = '0;
  hzif.exe_wsel = 5'h5;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = '0;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = 2'h2;

#(PERIOD)

  hzif.rs = 5'h0;
  hzif.rt = '0;
  hzif.exe_wsel = 5'h0;
  hzif.mem_wsel = '0;
  hzif.ihit = '0;
  hzif.dhit = 1'b1;
  hzif.MemRd = '0;
  hzif.MemWr = '0;
  hzif.PCSrc = '0;

  $finish;
end
endprogram
