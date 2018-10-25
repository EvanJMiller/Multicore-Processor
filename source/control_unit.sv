// interface
`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

// import types
import cpu_types_pkg::*;

module control_unit(
  control_unit_if.ctrlu ctrluif
);

always_comb begin
  ctrluif.RegDst   = 1'b0;
  ctrluif.RegWr    = 1'b0;
  ctrluif.MemtoReg = 2'b00;
  ctrluif.MemRd    = 1'b0;
  ctrluif.MemWr    = 1'b0;
  ctrluif.ALUSrc   = 1'b0;
  ctrluif.ALUOp    = ALU_SLL;
  ctrluif.ExtOp    = EX_ZERO;
  ctrluif.branch   = 1'b0;
  ctrluif.jal      = 1'b0;
  ctrluif.PCSrc    = 2'b00;
  ctrluif.shift    = 1'b0;
  ctrluif.halt     = 1'b0;

  casez(ctrluif.op)
    // rtype
    RTYPE : begin
      // set register destination mux to 1 for rd
      ctrluif.RegDst   = 1'b1;

      // set register write mux to 1 if not jumping to register
      if (ctrluif.func != JR) begin
        ctrluif.RegWr  = 1'b1;
      end

      // PCSrc = 01 if jumping to register
      if (ctrluif.func == JR) begin
        ctrluif.PCSrc  = 2'b01;
      end

      // set shift mux if shifting left or right
      if ((ctrluif.func == SLL) | (ctrluif.func == SRL)) begin
        ctrluif.shift  = 1'b1;
      end

      unique casez(ctrluif.func)
        // funct, set ALUOp accordingly
          SLL : begin
            ctrluif.ALUOp = ALU_SLL;
          end
          SRL : begin
            ctrluif.ALUOp = ALU_SRL;
          end
          JR : begin
            ctrluif.ALUOp = ALU_SLL;
          end
          ADD : begin
            ctrluif.ALUOp = ALU_ADD;
          end
          ADDU : begin
            ctrluif.ALUOp = ALU_ADD;
          end
          SUB : begin
            ctrluif.ALUOp = ALU_SUB;
          end
          SUBU : begin
            ctrluif.ALUOp = ALU_SUB;
          end
          AND : begin
            ctrluif.ALUOp = ALU_AND;
          end
          OR : begin
            ctrluif.ALUOp = ALU_OR;
          end
          XOR : begin
            ctrluif.ALUOp = ALU_XOR;
          end
          NOR : begin
            ctrluif.ALUOp = ALU_NOR;
          end
          SLT : begin
            ctrluif.ALUOp = ALU_SLT;
          end
          SLTU : begin
            ctrluif.ALUOp = ALU_SLTU;
          end
          default : begin
            ctrluif.ALUOp = ALU_SLL;
          end
        endcase // ctrluif.func case
    end // RTYPE case

    // jtype
    // PCSrc = 11 if jumping, or jumping and linking
    J : begin
      ctrluif.PCSrc    = 2'b11;
    end

    // writing return address to register 31, set register write mux to 1
    // set memory to register mux to 11 for choosing to write PC+4 to the register
    JAL : begin

      ctrluif.jal      = 1'b1;
      ctrluif.RegWr    = 1'b1;
      ctrluif.PCSrc    = 2'b11;
      ctrluif.MemtoReg = 2'b11;
    end

    // itype
    // for BEQ: branch = 1 chooses PCSrc as 10 (branch) only if zero flag IS set
    // otherwise, 00 will be fed into the zero-flag controlled mux by setting it here
    BEQ : begin
      ctrluif.ALUOp    = ALU_SUB;
      ctrluif.PCSrc    = 2'b00;
      ctrluif.branch   = 1'b1;
      //ctrluif.ExtOp    = EX_SIGNED;
    end

    // for BNE: branch = 0 chooses PCSrc as 10 (branch) only if zero flag is NOT set
    // otherwise, 00 will be fed into the zero-flag controlled mux by setting it in the datapath glue logic
    BNE : begin
      ctrluif.ALUOp    = ALU_SUB;
      ctrluif.PCSrc    = 2'b10;
     // ctrluif.ExtOp    = EX_SIGNED;
    end

    ADDI : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_ADD;
      ctrluif.ExtOp    = EX_SIGNED;
    end

    ADDIU : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_ADD;
      ctrluif.ExtOp    = EX_SIGNED;
    end

    SLTI : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_SLT;
      ctrluif.ExtOp    = EX_SIGNED;
    end

    SLTIU : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_SLTU;
      ctrluif.ExtOp    = EX_SIGNED;
    end

    ANDI : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_AND;
      ctrluif.ExtOp    = EX_ZERO;
    end

    ORI : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_OR;
      ctrluif.ExtOp    = EX_ZERO;
    end

    XORI : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_XOR;
      ctrluif.ExtOp    = EX_ZERO;
    end

    LUI : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_OR;
      ctrluif.ExtOp    = EX_UPPER;
      ctrluif.MemtoReg = 2'b01;
    end

    LW : begin
      ctrluif.RegWr    = 1'b1;
      ctrluif.MemRd    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_ADD;
      ctrluif.ExtOp    = EX_SIGNED;
      ctrluif.MemtoReg = 2'b10;
    end

    SW : begin
      ctrluif.MemWr    = 1'b1;
      ctrluif.ALUSrc   = 1'b1;
      ctrluif.ALUOp    = ALU_ADD;
      ctrluif.ExtOp    = EX_SIGNED;
    end

    HALT : begin
      ctrluif.halt     = 1'b1;
    end

  endcase
end // always_comb

endmodule
