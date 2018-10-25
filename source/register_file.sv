//  interface
`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

module register_file(
    input logic CLK, nRST,
    register_file_if.rf rfif
);

word_t [31:0] registers = '0;

always_ff @(negedge CLK, negedge nRST) begin
  // reset
  if (nRST == 1'b0) begin
    registers[31:0] <= '0;

  end
  // write enabled
  else begin
    if (rfif.WEN == 1'b1) begin
      // register 0 has const value of 0x00000000
      if (rfif.wsel != 1'b0) begin  // don't write to reg0
        registers[rfif.wsel] <= rfif.wdat;
      end
    end
  end
end // always_ff

// assign outputs
assign rfif.rdat1 = registers[rfif.rsel1];
assign rfif.rdat2 = registers[rfif.rsel2];

endmodule
