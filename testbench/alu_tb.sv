// mapped needs this
`include "alu_if.vh"

// mapped timing needs this, 1ns is too fast
`timescale 1 ns / 1 ns

// all types
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0;

  // test vars
  int v1 = 3;
  int v2 = 4;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif ();
  // test program
  test PROG (CLK, v1, v2, aluif);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.ALUOP    (aluif.ALUOP),
    .\aluif.porta    (aluif.porta),
    .\aluif.portb    (aluif.portb),
    .\aluif.negative (aluif.negative),
    .\aluif.out      (aluif.out),
    .\aluif.overflow (aluif.overflow),
    .\aluif.zero     (aluif.zero)
  );
`endif

endmodule

program test(
  input logic CLK,
  input int v1, v2,
  alu_if.tb tb
);
  parameter PERIOD = 10;
  initial begin

  // Testing add
  @(posedge CLK);
  tb.porta = 32'd10;
  tb.portb = 32'd15;
  tb.ALUOP = ALU_ADD;
  @(posedge CLK);
  $display("TEST CASE 1: Adding %d and %d", tb.porta, tb.portb);
  $display("OUT: %d\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing add with overflow
  @(posedge CLK);
  tb.porta = 32'h6FFFFFFF;
  tb.portb = 32'h6FFFFFFF;
  tb.ALUOP = ALU_ADD;
  @(posedge CLK);
  $display("TEST CASE 2: Adding %d and %d", tb.porta, tb.portb);
  $display("OUT: %d\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing add two zeros
  @(posedge CLK);
  tb.porta = 0;
  tb.portb = 0;
  tb.ALUOP = ALU_ADD;
  @(posedge CLK);
  $display("TEST CASE 2: Adding %d and %d", tb.porta, tb.portb);
  $display("OUT: %d\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing subtract
  @(posedge CLK);
  tb.porta = 32'd32;
  tb.portb = 32'd18;
  tb.ALUOP = ALU_SUB;
  @(posedge CLK);
  $display("TEST CASE 2: Subtracting %d and %d", tb.porta, tb.portb);
  $display("OUT: %d\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing subtract - overflow
  @(posedge CLK);
  tb.porta = 32'h6FFFFFFF;
  tb.portb = 32'h80000000;
  tb.ALUOP = ALU_SUB;
  @(posedge CLK);
  $display("TEST CASE 2: Subtracting %d and %d", tb.porta, tb.portb);
  $display("OUT: %d\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing subtract to zero
  @(posedge CLK);
  tb.porta = 32'd18;
  tb.portb = 32'd18;
  tb.ALUOP = ALU_SUB;
  @(posedge CLK);
  $display("TEST CASE 2: Subtracting %d and %d", tb.porta, tb.portb);
  $display("OUT: %d\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing left shift
  @(posedge CLK);
  tb.porta = 32'hFFFF;
  tb.portb = 32'd16;
  tb.ALUOP = ALU_SLL;
  @(posedge CLK);
  $display("TEST CASE 2: Shifting %b by %d", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing left shift to 0
  @(posedge CLK);
  tb.porta = 32'hFFFF0000;
  tb.portb = 32'd16;
  tb.ALUOP = ALU_SLL;
  @(posedge CLK);
  $display("TEST CASE 2: Shifting %b by %d", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing and
  @(posedge CLK);
  tb.porta = 32'h0000AF34;
  tb.portb = 32'h0000AF34;
  tb.ALUOP = ALU_AND;
  @(posedge CLK);
  $display("TEST CASE 2: Anding:\n     %b\n     %b", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing or
  @(posedge CLK);
  tb.porta = 32'h0000AF34;
  tb.portb = 32'h00000000;
  tb.ALUOP = ALU_OR;
  @(posedge CLK);
  $display("TEST CASE 2: Oring:\n     %b\n     %b", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing xor
  @(posedge CLK);
  tb.porta = 32'h0000AF34;
  tb.portb = 32'h0000AF32;
  tb.ALUOP = ALU_XOR;
  @(posedge CLK);
  $display("TEST CASE 2: Xoring:\n     %b\n     %b", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing nor
  @(posedge CLK);
  tb.porta = 32'h0000AF34;
  tb.portb = 32'h0000AF32;
  tb.ALUOP = ALU_NOR;
  @(posedge CLK);
  $display("TEST CASE 2: Noring:\n     %b\n     %b", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing setting less than
  @(posedge CLK);
  tb.porta = 32'd15;
  tb.portb = 32'd16;
  tb.ALUOP = ALU_SLT;
  @(posedge CLK);
  $display("TEST CASE 2: Setting %d < %d", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing setting less than
  @(posedge CLK);
  tb.porta = 32'd1031;
  tb.portb = 32'd16;
  tb.ALUOP = ALU_SLT;
  @(posedge CLK);
  $display("TEST CASE 2: Setting %d < %d", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);

  // Testing setting less than unsigned
  @(posedge CLK);
  tb.porta = 32'hFFFFFFFE;
  tb.portb = 32'hFFFFFFFF;
  tb.ALUOP = ALU_SLT;
  @(posedge CLK);
  $display("TEST CASE 2: Setting %d < %d", tb.porta, tb.portb);
  $display("OUT: %b\nOVERFLOW: %d\nNEGATIVE: %d\nZERO: %d\n",
            aluif.out, aluif.overflow, aluif.negative, aluif.zero);


  $finish;
  end
endprogram
