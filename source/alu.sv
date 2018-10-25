// interface
`include "alu_if.vh"
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

module alu(
  alu_if.alu aluif
);

logic [31:0] temp_out;
logic temp_overflow;

always_comb begin
  temp_out = '0;
  temp_overflow = 1'b0;

  casez(aluif.ALUOP)
    // shift left logical - ALU_SLL
    ALU_SLL: begin
      temp_out = aluif.porta << aluif.portb;
    end

    // shift right logical - ALU_SRL
    ALU_SRL: begin
      temp_out = aluif.porta >> aluif.portb;
    end

    // add - ALU_ADD
    ALU_ADD: begin
      temp_out = aluif.porta + aluif.portb;

      if((aluif.porta[31] == aluif.portb[31]) & (aluif.porta[31] != temp_out[31])) begin
          temp_overflow  = 1'b1;
        end else begin
          temp_overflow  = 1'b0;
        end
    end

    // subtract - ALU_SUB
    ALU_SUB: begin
      temp_out = aluif.porta - aluif.portb;

      if((aluif.porta[31] != aluif.portb[31]) & (aluif.portb[31] == temp_out[31])) begin
          temp_overflow = 1'b1;
        end else begin
          temp_overflow = 1'b0;
        end
    end

    // and - ALU_AND
    ALU_AND: begin
      temp_out = {1'b0, aluif.porta & aluif.portb};
    end

    // or - ALU_OR
    ALU_OR: begin
      temp_out = {1'b0, aluif.porta | aluif.portb};
    end

    // xor - ALU_XOR
    ALU_XOR: begin
      temp_out =  aluif.porta ^ aluif.portb;
    end

    // nor - ALU_NOR
    ALU_NOR: begin
      temp_out = ~(aluif.porta | aluif.portb);
    end

    // set less than signed - ALU_SLT
    ALU_SLT: begin
      if(signed'(aluif.porta) < signed'(aluif.portb)) begin
        temp_out = 32'd1;
      end
      else begin temp_out = '0; end
    end

    // set less than unsigned - ALU_SLTU
    ALU_SLTU: begin
      if(aluif.porta < aluif.portb) begin
        temp_out = 32'd1;
      end
      else begin temp_out = '0; end
    end
  endcase
end

// assign output
assign aluif.out = temp_out;
assign aluif.negative = temp_out[31];
assign aluif.overflow = temp_overflow;
assign aluif.zero = (aluif.out == '0) ? 1'b1 : 1'b0;

endmodule
