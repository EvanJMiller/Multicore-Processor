// interface
`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

module hazard_unit(
  hazard_unit_if.hazard hzif
);
//logic load_if, hazard_if;

always_comb begin
    // default values
    hzif.fetch_EN   = 1'b0;
    hzif.decode_EN  = 1'b0;
    hzif.exe_EN     = 1'b0;
    hzif.mem_EN     = 1'b0;
    hzif.fetch_NOP  = 1'b0;
    hzif.decode_NOP = 1'b0;
    hzif.exe_NOP    = 1'b0;
    hzif.mem_NOP    = 1'b0;
    hzif.PCWE       = 1'b0;


     // if a jump or branch is occuring, flush fetch, decode, and execute latches

   /*if (hzif.PCSrc > 2'b00) begin
     hzif.decode_NOP = 1;
     hzif.fetch_NOP = 1;
     hzif.exe_NOP = 1;
     hzif.fetch_EN   = 1'b1;
     hzif.decode_EN  = 1'b1;
     hzif.exe_EN     = 1'b1;
     hzif.mem_EN     = 1'b1;
   end*/

   //else if (!ihit & !dhit &  (MemRd | MemWr))
   //waiting for hits...

   //else if (ihit & !dhit & (memRd | memWr))
   // hzif.fetch_NOP = 1;
   // PCWE = 0;

   // else if (!ihit & dhit & (memRd | memWr))
   // hzif.decode_EN  = 1'b1;
   // hzif.exe_EN     = 1'b1;
   // hzif.mem_EN     = 1'b1;

   //else if (dhit & ihit & (MemRd | MemWr)))
   // PCWE = 1
   // hzif.fetch_EN   = 1'b1;
   // hzif.decode_EN  = 1'b1;
   // hzif.exe_EN     = 1'b1;
   // hzif.mem_EN     = 1'b1;


   //set instruction R as 0
   //such that data always priority




  // if a jump or branch is occuring, flush fetch, decode, and execute latches
  if (hzif.PCSrc > 2'b00 & !hzif.ihit) begin
  //if (hzif.PCSrc > 2'b00) begin
     hzif.decode_NOP = 1;
     hzif.fetch_NOP = 1;
    hzif.PCWE       = 1'b1;
     //hzif.exe_NOP = 1;
     //hzif.fetch_EN   = 1'b1;
     //hzif.decode_EN  = 1'b1;
     //hzif.exe_EN     = 1'b1;
     //hzif.mem_EN     = 1'b1;
     //hzif.PCWE = 1'b0i;
  end
  //else if (hzif.PCSrc > 2'b00 & hzif.ihit) begin
  //  hzif.fetch_NOP = 1;
  //end

  // if a read or write is occuring, stall latches
  else if (hzif.MemRd | hzif.MemWr) begin
     //hzif.fetch_NOP = 1'b1;
    // hzif.PCWE = 1'b0;
    // if a dhit occurs, the write or read has completed, unstall latches
    if (hzif.dhit) begin
    hzif.PCWE       = 1'b1;
      hzif.fetch_EN  = 1'b1;
      hzif.decode_EN = 1'b1;
      hzif.exe_EN    = 1'b1;
      hzif.mem_EN    = 1'b1;
    end
  end
  /*
  // if a read after write hazard is occuring, stall PC, fetch, and decode latches, insert nop into decode latch
  else if (((hzif.exe_wsel == hzif.rs) | (hzif.exe_wsel == hzif.rt)) & (hzif.rs != 5'd0)) begin
    hzif.PCWE       = 1'b0;
    hzif.exe_EN     = 1'b1;
    hzif.mem_EN     = 1'b1;
    hzif.decode_NOP = 1'b1;
  end
  else if (((hzif.mem_wsel == hzif.rs) | (hzif.mem_wsel == hzif.rt)) & (hzif.rs != 5'd0)) begin
    hzif.PCWE       = 1'b0;
    hzif.exe_EN     = 1'b1;
    hzif.mem_EN     = 1'b1;
    hzif.decode_NOP = 1'b1;
  end
  */
  // else not waiting on memory or hazard, all latches enabled
  else if(hzif.ihit == 1'b1) begin
    hzif.PCWE       = 1'b1;
    hzif.fetch_EN  = 1'b1;
    hzif.decode_EN = 1'b1;
    hzif.exe_EN    = 1'b1;
    hzif.mem_EN    = 1'b1;
  end

end // always_comb

endmodule
