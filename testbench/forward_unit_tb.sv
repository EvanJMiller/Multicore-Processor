`include "forward_unit_if.vh"

`timescale 1 ns / 1 ns

`include "forward_unit_if.vh"
`include "cpu_types_pkg.vh"

module forward_unit_tb;

   parameter PERIOD = 10;
   logic CLK = 0;
   logic nRST;

   always #(PERIOD/2) CLK++;

   forward_unit_if fuif();
   test PROG (CLK, nRST, fuif);
   forward_unit fu (fuif);

endmodule // forward_unit_tb

program test (input logic CLK, output logic nRST, forward_unit_if.tb futb);
  initial begin

     parameter PERIOD = 10;     
	
     futb.ex_rsel1 = 5'h0; 
     futb.ex_rsel2 = 5'h0;
     futb.ex_rdat1 = 32'hA;
     futb.ex_rdat2 = 32'hB;
     futb.mem_wsel = 5'h0;
     futb.mem_dat = 32'hC;
     futb.wb_wsel = 5'h0;
     futb.wb_dat = 32'hD;
     futb.memToReg = '0;
     futb.mem_wen = '1;
     futb.wb_wen = '1;
     #(PERIOD/2)

     futb.ex_rsel1 = 5'h1; 
     futb.ex_rsel2 = 5'h2;
     futb.ex_rdat1 = 32'hA;
     futb.ex_rdat2 = 32'hB;
     futb.mem_wsel = 5'h1;
     futb.mem_dat = 32'hC;
     futb.wb_wsel = 5'h2;
     futb.wb_dat = 32'hD;
     futb.memToReg = '0;
     futb.mem_wen = '1;
     futb.wb_wen = '1;
     #(PERIOD/2)
     
     futb.ex_rsel1 = 5'h1; 
     futb.ex_rsel1 = 5'h2;
     futb.ex_rdat2 = 32'hA;
     futb.ex_rdat2 = 32'hB;
     futb.mem_wsel = 5'h5;
     futb.mem_dat = 32'hC;
     futb.wb_wsel = 5'h6;
     futb.wb_dat = 32'hD;
     futb.memToReg = '0;
     futb.mem_wen = '1;
     futb.wb_wen = '1;
     #(PERIOD/2)

      $finish;
     

     

   end
   endprogram
