// interface
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

module extender(
  input logic [15:0] imm16,
  input ex_t ExtOp,
  output word_t out
);

always_comb begin
  out = 32'd0;

  casez(ExtOp)
    EX_ZERO : begin
      out = {16'd0, imm16};
    end
    EX_SIGNED : begin
      out = {{16{imm16[15]}}, imm16};
    end
    EX_UPPER : begin
      out = {imm16, 16'd0};
    end
  endcase
end

endmodule
