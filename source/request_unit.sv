// interface
`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

module request_unit(
  input logic CLK, nRST,
  request_unit_if.requ ruif
);

  logic next_dREN, next_dWEN, dREN_reg, dWEN_reg;

always_ff @(posedge CLK, negedge nRST) begin
  // reset
  if (nRST == 1'b0) begin
    ruif.iREN <= 1'b0;
    dREN_reg <= 1'b0;
    dWEN_reg <= 1'b0;

  end

  else begin
    ruif.iREN <= 1'b1;
    dREN_reg <= next_dREN;
    dWEN_reg <= next_dWEN;
  end
end // always_ff

always_comb begin
  if (ruif.dhit == 1'b1) begin
    next_dREN = 1'b0;
    next_dWEN = 1'b0;
  end
  else if (ruif.ihit == 1'b1) begin
    next_dREN = ruif.MemRd;
    next_dWEN = ruif.MemWr;
  end
  else begin
    next_dREN = dREN_reg;
    next_dWEN = dWEN_reg;
  end

end // always_comb

assign ruif.dREN = dREN_reg;
assign ruif.dWEN = dWEN_reg;
endmodule
