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
  //cache_control_if ccif();
  cpu_ram_if ramif ();

/*
  // test program
  test PROG (CLK,
nRST,
ccif.cif0.iwait,
ccif.cif0.dwait,
ccif.cif0.iload,
ccif.cif0.dload,
ccif.cif0.iREN,
ccif.cif0.dREN,
ccif.cif0.dWEN,
ccif.cif0.dstore,
ccif.cif0.iaddr,
ccif.cif0.daddr,
ccif.ramWEN,
ccif.ramREN,
ccif.ramstore,
ccif.ramaddr,
ccif.ramload
);
*/
  // test program
  test PROG(CLK, nRST, ccif);

  // DUT
`ifndef MAPPED
  memory_control DUT(CLK, nRST, ccif);
`else
  memory_control DUT(
    .\CLK (CLK),
    .\nRST     (nRST),
    .\iREN     (ccif.iREN),
    .\dREN     (ccif.dREN),
    .\dWEN     (ccif.dWEN),
    .\dstore   (ccif.dstore),
    .\iaddr    (ccif.iaddr),
    .\daddr    (ccif.daddr),
    .\ramload  (ccif.ramload),
    .\ramstate (ccif.ramstate),
    .\iwait    (ccif.iwait),
    .\dwait    (ccif.dwait),
    .\iload    (ccif.iload),
    .\dload    (ccif.dload),
    .\ramstore (ccif.ramstore),
    .\ramaddr  (ccif.ramaddr),
    .\ramWEN   (ccif.ramWEN),
    .\ramREN   (ccif.ramREN)
  );
`endif

`ifndef MAPPED
  ram RAM_DUT(CLK, nRST, ramif);
`else
  ram RAM_DUT(
    .\CLK      (CLK),
    .\nRST     (nRST),
    .\ramaddr  (ramif.ramaddr),
    .\ramstore (ramif.ramstore),
    .\ramREN   (ramif.ramREN),
    .\ramWEN   (ramif.ramWEN),
    .\ramstate (ramif.ramstate),
    .\ramload  (ramif.ramload)
  );
`endif

  // assign pass-through signals
  assign ramif.ramaddr  = ccif.ramaddr;
  assign ramif.ramstore = ccif.ramstore;
  assign ramif.ramREN   = ccif.ramREN;
  assign ramif.ramWEN   = ccif.ramWEN;
  assign ccif.ramstate = ramif.ramstate;
  assign ccif.ramload  = ramif.ramload;

endmodule

program test(
  input  logic     CLK,
  output logic     nRST,
  input logic iwait, dwait,
  input word_t iload, dload,
  output logic iREN, dREN, dWEN,
  output word_t dstore, iaddr, daddr,
  input logic ramWEN, ramREN,
  input word_t ramstore, ramaddr,
  output word_t ramload
);

program test(input logic CLK,
  output logic nRST,
  cache_control_if ccif
);

  import cpu_types_pkg::*;
  int test_case = 1;


  int cnt;
  int file, n;
  reg [31:0] c;
  reg eof;
  parameter PERIOD = 10;
  initial begin
  nRST = 1'b0;
  #(PERIOD)
  nRST = 1'b1;
  #(PERIOD)


  // Test 1 - Read Instruction
  ccif.cif0.iREN = 1'b1;
  ccif.cif0.dREN = 1'b0;
  ccif.cif0.dWEN = 1'b0;
  ccif.cif0.iaddr = '0;
  $display("TEST CASE %2d - Read Instruction\n", test_case);
  for(cnt = 0; cnt <= 16; cnt++) begin
    @(negedge ccif.cif0.iwait);
    if(ccif.cif0.iload == ccif.ramload) begin
      $display("Successfully read instruction!\n");
    end else begin
      $display("FAILED to read instruction!\n");
    end
    #(PERIOD)
    ccif.cif0.iaddr += 32'd4;
  end
  test_case += 1;

  // Test 2 - Read Data
  ccif.cif0.iREN = 1'b0;
  ccif.cif0.dREN = 1'b1;
  ccif.cif0.dWEN = 1'b0;
  ccif.cif0.daddr = 32'h00000080;
  $display("TEST CASE %2d - Read Data\n", test_case);
  for(cnt = 0; cnt <= 10; cnt++) begin
    @(negedge ccif.cif0.dwait);
    if(ccif.cif0.dload == ccif.ramload) begin
      $display("Successfully read data!\n");
    end else begin
      $display("FAILED to read data!\n");
    end
    #(PERIOD)
    ccif.cif0.daddr += 32'd4;
  end
  test_case += 1;


  // Test 3 - Give priority to data
  ccif.cif0.iREN = 1'b1;
  ccif.cif0.dREN = 1'b1;
  ccif.cif0.dWEN = 1'b0;
  ccif.cif0.iaddr = 32'h0010;
  ccif.cif0.daddr = 32'h0080;
  $display("TEST CASE %2d - Read Data\n", test_case);
  for(cnt = 0; cnt <= 10; cnt++) begin
    @(negedge ccif.cif0.dwait);
    if(ccif.cif0.dload == ccif.ramload && ccif.cif0.dwait == 1'b0) begin
      $display("Successfully gave priority to  data!\n");
    end else begin
      $display("FAILED to give priority to  data!\n");
    end
    #(PERIOD)
    ccif.cif0.iaddr += 32'd4;
    ccif.cif0.daddr += 32'd4;
  end
  test_case += 1;

  // Test 4 - Write Data
  ccif.cif0.iREN = 1'b1;
  ccif.cif0.dREN = 1'b0;
  ccif.cif0.dWEN = 1'b1;
  ccif.cif0.iaddr = 32'h0000;
  ccif.cif0.daddr = 32'h0000;
  $display("TEST CASE %2d - Write Data\n", test_case);
  for(cnt = 0; cnt <= 10; cnt++) begin
    ccif.cif0.dstore = cnt;
    @(negedge ccif.cif0.dwait);
    if(ccif.cif0.dstore == ccif.ramstore && ccif.cif0.dwait == 1'b0) begin
      $display("Successfully wrote data to RAM!\n");
    end else begin
      $display("FAILED to write data to RAM!\n");
    end
    #(PERIOD)
    ccif.cif0.daddr += 32'd4;
  end
  test_case += 1;


  // Test 5 - Read previously written data
  ccif.cif0.iREN = 1'b1;
  ccif.cif0.dREN = 1'b1;
  ccif.cif0.dWEN = 1'b0;
  ccif.cif0.iaddr = 32'h0030;
  ccif.cif0.daddr = 32'h0000;
  $display("TEST CASE %2d - Read Previously Written Data\n", test_case);
  for(cnt = 0; cnt <= 10; cnt++) begin
    @(negedge ccif.cif0.dwait);
    if(ccif.cif0.dload == ccif.ramload) begin
      $display("Successfully read previously written data to RAM!\n");
    end else begin
      $display("FAILED to read previously  written data to RAM!\n");
    end
    #(PERIOD)
    ccif.cif0.daddr += 32'd4;
  end
  test_case += 1;


  dump_memory();


end

  task automatic dump_memory();
    string filename = "cpudump.hex";
    int memfd;

    //syif.tbCTRL = 1;
    //syif.addr = 0;
    //syif.WEN = 0;
    //syif.REN = 0;
    ccif.cif0.iaddr = 0;
    ccif.cif0.iREN = 0;
    ccif.cif0.dWEN = 0;
    ccif.cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      //syif.addr = i << 2;
      //syif.REN = 1;
      ccif.cif0.iaddr = i << 2;
      ccif.cif0.iREN = 1;

      repeat (4) @(posedge CLK);
      if (ccif.cif0.iload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,ccif.cif0.iload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),ccif.cif0.iload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //syif.tbCTRL = 0;
      ccif.cif0.iREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask


endprogram
