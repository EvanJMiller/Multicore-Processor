/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, v1, v2, v3, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(
  input logic CLK,
  input int v1, v2, v3,
  output logic nRST,
  register_file_if.tb tb
);
  parameter PERIOD = 10;
  initial begin
  nRST = 0;
  @(negedge CLK);
  nRST = 1;
  tb.rsel1 = 5'd0;
  tb.rsel2 = 5'd1;
  $monitor("@%00g CLK = %b nRST = %b rdat1 = %d rdat2 = %d",
  $time, CLK, nRST, tb.rdat1, tb.rdat2);
  #(PERIOD)

  // test case 1 - writing to register 7
  @(negedge CLK);
  //nRST = 1;
  tb.WEN = 1'b1;
  tb.wdat = v1;
  tb.wsel = 5'd7;
  @(negedge CLK);
  tb.WEN = 1'b0;
  tb.rsel1 = 5'd7;
  tb.rsel2 = 5'd0;
  @(negedge CLK);
  $monitor("@%00g CLK = %b nRST = %b rdat1 = %d rdat2 = %d",
  $time, CLK, nRST, tb.rdat1, tb.rdat2);

  // test case 2 - writing to register 4
  @(negedge CLK);
  tb.WEN = 1'b1;
  tb.wdat = v2;
  tb.wsel = 5'd4;
  @(negedge CLK);
  tb.WEN = 1'b0;
  tb.rsel1 = 5'd7;
  tb.rsel2 = 5'd4;
  @(negedge CLK);
  $monitor("@%00g CLK = %b nRST = %b rdat1 = %d rdat2 = %d",
  $time, CLK, nRST, tb.rdat1, tb.rdat2);

  // test case 3 - overwriting register 7
  @(negedge CLK);
  tb.WEN = 1'b1;
  tb.wdat = v3;
  tb.wsel = 5'd7;
  @(negedge CLK);
  tb.WEN = 1'b0;
  tb.rsel1 = 5'd7;
  tb.rsel2 = 5'd4;
  @(negedge CLK);
  $monitor("@%00g CLK = %b nRST = %b rdat1 = %d rdat2 = %d",
  $time, CLK, nRST, tb.rdat1, tb.rdat2);

  // test case 4 - writing to register 0
  @(negedge CLK);
  tb.WEN = 1'b1;
  tb.wdat = v2;
  tb.wsel = 5'd0;
  @(negedge CLK);
  tb.WEN = 1'b0;
  tb.rsel1 = 5'd0;
  tb.rsel2 = 5'd4;
  @(negedge CLK);
  $monitor("@%00g CLK = %b nRST = %b rdat1 = %d rdat2 = %d",
  $time, CLK, nRST, tb.rdat1, tb.rdat2);

  // test case 5 - reset
  @(negedge CLK);
  nRST = 0;
  @(negedge CLK);
  tb.rsel1 = 5'd0;
  tb.rsel2 = 5'd4;
  @(negedge CLK);
  $monitor("@%00g CLK = %b nRST = %b rdat1 = %d rdat2 = %d",
  $time, CLK, nRST, tb.rdat1, tb.rdat2);

  // test case 6 - writing to register 31 after reset
  @(negedge CLK);
  nRST = 1;
  tb.WEN = 1'b1;
  tb.wdat = v3;
  tb.wsel = 5'd31;
  @(negedge CLK);
  tb.rsel1 = 5'd31;
  tb.rsel2 = 5'd4;
  @(negedge CLK);
  $monitor("@%00g CLK = %b nRST = %b rdat1 = %d rdat2 = %d",
  $time, CLK, nRST, tb.rdat1, tb.rdat2);

  $finish;
  end
endprogram
