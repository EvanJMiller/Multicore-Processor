/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interfaces
`include "datapath_cache_if.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
`include "control_unit_if.vh"
`include "fetch_reg_if.vh"
`include "decode_reg_if.vh"
`include "exe_reg_if.vh"
`include "mem_reg_if.vh"
`include "hazard_unit_if.vh"
`include "forward_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (

  input logic CLK, nRST,
	      datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;
  word_t pc;
  word_t npc;
  word_t pc_4, pc_jump, pc_branch, pc_register;

  // extender unit iniim:/system_tb/DUT/CPU/DP/drif/exe_pc_4

  word_t ext_out;

  // latch enables init
  logic fetch_EN, decode_EN, exe_EN, mem_EN;
  logic fetch_FLUSH, decode_FLUSH, exe_FLUSH;

  logic PCSrc, next_PCSrc;
  // interfaces
  register_file_if rfif();
  alu_if           aluif();
  control_unit_if  ctrluif();
  fetch_reg_if     frif();
  decode_reg_if    drif();
  exe_reg_if       erif();
  mem_reg_if       mrif();
  hazard_unit_if   hzif();
  forward_unit_if fuif();


  // DUT
  register_file REG (CLK, nRST, rfif.rf);
  alu           ALU (aluif.alu);
  control_unit  CTR (ctrluif.ctrlu);
  extender      EXT (.imm16 (frif.decode_imemload[15:0]), .ExtOp (ctrluif.ExtOp), .out (ext_out));
  hazard_unit   HZD (hzif.hazard);
  forward_unit FWD (fuif.fu);


  // ########## PIPELINE LATCHES ########## //

  // ---------- Fetch register & fetch stage ---------- //
  assign fetch_EN = hzif.fetch_EN;
  assign fetch_FLUSH = hzif.fetch_NOP;

  always_ff @(posedge CLK, negedge nRST) begin
    // reset or nop injection
    //if(nRST == 1'b0 | hzif.fetch_NOP == 1'b1) begin
    if(nRST == 1'b0) begin
      // data signals
      frif.decode_pc_4 <= '0;
      frif.decode_imemload <= '0;
    end
    // flush
    else if(fetch_FLUSH == 1'b1 || PCSrc == 1'b0) begin
      //frif.fetch_pc_4 <= '0;
      //frif.fetch_imemload <= '0;
      frif.decode_pc_4 <= '0;
      frif.decode_imemload <= '0;
    end
    // enabled
    else if(fetch_EN == 1'b1) begin
      // data signals
      frif.decode_pc_4 <= frif.fetch_pc_4;
      frif.decode_imemload <= frif.fetch_imemload;
    end

    // disabled, recycle latch outputs to inputs
    else begin
      // data signals
      frif.decode_pc_4 <= frif.decode_pc_4;
      frif.decode_imemload <= frif.decode_imemload;
    end
  end // fetch always_ff

  // attach fetch register to datapath and PC
  assign frif.fetch_pc_4     = pc_4;
  assign frif.fetch_imemload = dpif.imemload;


  // ---------- Decode register and decode stage ---------- //
  assign decode_EN = hzif.decode_EN;
  assign decode_FLUSH = hzif.decode_NOP;

  always_ff @(posedge CLK, negedge nRST) begin
    //reset or nop injections
    if(nRST == 1'b0) begin
      // control signals
       drif.op_out        <= RTYPE;
      drif.exe_halt      <= '0;
      drif.exe_RegWr     <= '0;
      drif.exe_MemtoReg  <= '0;
      drif.exe_MemWr     <= '0;
      drif.exe_MemRd     <= '0;
      drif.exe_branch    <= '0;
      drif.exe_PCSrc     <= '0;
      drif.exe_jal       <= '0;
      drif.exe_RegDst    <= '0;
      drif.exe_ALUOp     <= ALU_SLL;
      drif.exe_shift     <= '0;
      drif.exe_ALUSrc    <= '0;

      // data signals
      drif.exe_pc_4      <= '0;
      drif.exe_jump_addr <= '0;
      drif.exe_rdat1     <= '0;
      drif.exe_rdat2     <= '0;
      drif.exe_shamt     <= '0;
      drif.exe_ex_out    <= '0;
      drif.exe_rs        <= '0;
      drif.exe_rd        <= '0;
      drif.exe_rt        <= '0;
    end

    // flush
    else if(decode_FLUSH == 1'b1) begin
      // control signals
      drif.op_out        <= RTYPE;
      drif.exe_halt      <= '0;
      drif.exe_RegWr     <= '0;
      drif.exe_MemtoReg  <= '0;
      drif.exe_MemWr     <= '0;
      drif.exe_MemRd     <= '0;
      drif.exe_branch    <= '0;
      drif.exe_PCSrc     <= '0;
      drif.exe_jal       <= '0;
      drif.exe_RegDst    <= '0;
      drif.exe_ALUOp     <= ALU_SLL;
      drif.exe_shift     <= '0;
      drif.exe_ALUSrc    <= '0;

      // data signals
      drif.exe_pc_4      <= '0;
      drif.exe_jump_addr <= '0;
      drif.exe_rdat1     <= '0;
      drif.exe_rdat2     <= '0;
      drif.exe_shamt     <= '0;
      drif.exe_ex_out    <= '0;
      drif.exe_rs        <= '0;
      drif.exe_rd        <= '0;
      drif.exe_rt        <= '0;
    end

    // enabled
    else if(decode_EN == 1'b1) begin
      // control signals
       drif.op_out        <= drif.op_in;
      drif.exe_halt      <= drif.decode_halt;
      drif.exe_RegWr     <= drif.decode_RegWr;
      drif.exe_MemtoReg  <= drif.decode_MemtoReg;
      drif.exe_MemWr     <= drif.decode_MemWr;
      drif.exe_MemRd     <= drif.decode_MemRd;
      drif.exe_branch    <= drif.decode_branch;
      drif.exe_PCSrc     <= drif.decode_PCSrc;
      drif.exe_jal       <= drif.decode_jal;
      drif.exe_RegDst    <= drif.decode_RegDst;
      drif.exe_ALUOp     <= drif.decode_ALUOp;
      drif.exe_shift     <= drif.decode_shift;
      drif.exe_ALUSrc    <= drif.decode_ALUSrc;

      // data signals
      drif.exe_pc_4      <= drif.decode_pc_4;
      drif.exe_jump_addr <= drif.decode_jump_addr;
      drif.exe_rdat1     <= drif.decode_rdat1;
      drif.exe_rdat2     <= drif.decode_rdat2;
      drif.exe_shamt     <= drif.decode_shamt;
      drif.exe_ex_out    <= drif.decode_ex_out;
      drif.exe_rs        <= drif.decode_rs;
      drif.exe_rd        <= drif.decode_rd;
      drif.exe_rt        <= drif.decode_rt;
    end

    // disabled, recycle latch outputs to inputs
    else begin
      // control signals
      drif.op_out        <= drif.op_out;
      drif.exe_halt      <= drif.exe_halt;
      drif.exe_RegWr     <= drif.exe_RegWr;
      drif.exe_MemtoReg  <= drif.exe_MemtoReg;
      drif.exe_MemWr     <= drif.exe_MemWr;
      drif.exe_MemRd     <= drif.exe_MemRd;
      drif.exe_branch    <= drif.exe_branch;
      drif.exe_PCSrc     <= drif.exe_PCSrc;
      drif.exe_jal       <= drif.exe_jal;
      drif.exe_RegDst    <= drif.exe_RegDst;
      drif.exe_ALUOp     <= drif.exe_ALUOp;
      drif.exe_shift     <= drif.exe_shift;
      drif.exe_ALUSrc    <= drif.exe_ALUSrc;

      // data signals
      drif.exe_pc_4      <= drif.exe_pc_4;
      drif.exe_jump_addr <= drif.exe_jump_addr;
      drif.exe_rdat1     <= drif.exe_rdat1;
      drif.exe_rdat2     <= drif.exe_rdat2;
      drif.exe_shamt     <= drif.exe_shamt;
      drif.exe_ex_out    <= drif.exe_ex_out;
      drif.exe_rs        <= drif.exe_rs;
      drif.exe_rd        <= drif.exe_rd;
      drif.exe_rt        <= drif.exe_rt;
    end
  end // always_ff

  // control signal connections
  assign drif.op_in[5:0]      = frif.decode_imemload[31:26];
  assign drif.decode_halt      = ctrluif.halt;
  assign drif.decode_RegWr     = ctrluif.RegWr;
  assign drif.decode_MemtoReg  = ctrluif.MemtoReg;
  assign drif.decode_MemWr     = ctrluif.MemWr;
  assign drif.decode_MemRd     = ctrluif.MemRd;
  assign drif.decode_branch    = ctrluif.branch;
  assign drif.decode_PCSrc     = ctrluif.PCSrc;
  assign drif.decode_jal       = ctrluif.jal;
  assign drif.decode_RegDst    = ctrluif.RegDst;
  assign drif.decode_ALUOp     = ctrluif.ALUOp;
  assign drif.decode_shift     = ctrluif.shift;
  assign drif.decode_ALUSrc    = ctrluif.ALUSrc;

  // data signal connections
  assign drif.decode_pc_4      = frif.decode_pc_4;
  assign drif.decode_jump_addr = frif.decode_imemload[25:0];
  assign drif.decode_rdat1     = rfif.rdat1;
  assign drif.decode_rdat2     = rfif.rdat2;
  assign drif.decode_shamt     = frif.decode_imemload[10:6];
  assign drif.decode_ex_out    = ext_out;
  assign drif.decode_rs        = frif.decode_imemload[25:21];
  assign drif.decode_rd        = frif.decode_imemload[15:11];
  assign drif.decode_rt        = frif.decode_imemload[20:16];

  // ---------- Execute register and execute stage ---------- //
  assign exe_EN = hzif.exe_EN;
  assign exe_FLUSH = hzif.exe_NOP;

  always_ff @(posedge CLK, negedge nRST) begin
    // reset
    if(nRST == 1'b0) begin
      // control signals
       erif.op_out         <= RTYPE;
      erif.mem_halt        <= '0;
      erif.mem_RegWr       <= '0;
      erif.mem_MemtoReg    <= '0;
      erif.mem_MemWr       <= '0;
      erif.mem_MemRd       <= '0;
      erif.mem_branch      <= '0;
      erif.mem_PCSrc       <= '0;

      // data signals
      erif.mem_pc_4        <= '0;
      erif.mem_jump_addr   <= '0;
      erif.mem_branch_addr <= '0;
      erif.mem_rdat1       <= '0;
      erif.mem_ex_out      <= '0;
      erif.mem_zero        <= '0;
      erif.mem_alu_out     <= '0;
      erif.mem_rdat2       <= '0;
      erif.mem_wsel        <= '0;
    end

    // flush
    else if(exe_FLUSH == 1'b1) begin
      // control signals
       erif.op_out         <= RTYPE;
      erif.mem_halt        <= '0;
      erif.mem_RegWr       <= '0;
      erif.mem_MemtoReg    <= '0;
      erif.mem_MemWr       <= '0;
      erif.mem_MemRd       <= '0;
      erif.mem_branch      <= '0;
      erif.mem_PCSrc       <= '0;

      // data signals
      erif.mem_pc_4        <= '0;
      erif.mem_jump_addr   <= '0;
      erif.mem_branch_addr <= '0;
      erif.mem_rdat1       <= '0;
      erif.mem_ex_out      <= '0;
      erif.mem_zero        <= '0;
      erif.mem_alu_out     <= '0;
      erif.mem_rdat2       <= '0;
      erif.mem_wsel        <= '0;
    end

    // enabled
    else if(exe_EN == 1'b1) begin
      // control signals
       erif.op_out         <= erif.op_in;
      erif.mem_halt        <= erif.exe_halt;
      erif.mem_RegWr       <= erif.exe_RegWr;
      erif.mem_MemtoReg    <= erif.exe_MemtoReg;
      erif.mem_MemWr       <= erif.exe_MemWr;
      erif.mem_MemRd       <= erif.exe_MemRd;
      erif.mem_branch      <= erif.exe_branch;
      erif.mem_PCSrc       <= erif.exe_PCSrc;

      // data signals
      erif.mem_pc_4        <= erif.exe_pc_4;
      erif.mem_jump_addr   <= erif.exe_jump_addr;
      erif.mem_branch_addr <= erif.exe_branch_addr;
      erif.mem_rdat1       <= erif.exe_rdat1;
      erif.mem_ex_out      <= erif.exe_ex_out;
      erif.mem_zero        <= erif.exe_zero;
      erif.mem_alu_out     <= erif.exe_alu_out;
      erif.mem_rdat2       <= erif.exe_rdat2;
      erif.mem_wsel        <= erif.exe_wsel;
    end

    // disabled, recycle latch outputs to inputs
    else begin
      // control signals
       erif.op_out         <= erif.op_out;
      erif.mem_halt        <= erif.mem_halt;
      erif.mem_RegWr       <= erif.mem_RegWr;
      erif.mem_MemtoReg    <= erif.mem_MemtoReg;
      erif.mem_MemWr       <= erif.mem_MemWr;
      erif.mem_MemRd       <= erif.mem_MemRd;
      erif.mem_branch      <= erif.mem_branch;
      erif.mem_PCSrc       <= erif.mem_PCSrc;

      // data signals
      erif.mem_pc_4        <= erif.mem_pc_4;
      erif.mem_jump_addr   <= erif.mem_jump_addr;
      erif.mem_branch_addr <= erif.mem_branch_addr;
      erif.mem_rdat1       <= erif.mem_rdat1;
      erif.mem_ex_out      <= erif.mem_ex_out;
      erif.mem_zero        <= erif.mem_zero;
      erif.mem_alu_out     <= erif.mem_alu_out;
      erif.mem_rdat2       <= erif.mem_rdat2;
      erif.mem_wsel        <= erif.mem_wsel;
    end
  end // always_ff

  // control signal connections
   assign erif.op_in = drif.op_out;
  assign erif.exe_halt        = drif.exe_halt;
  assign erif.exe_RegWr       = drif.exe_RegWr;
  assign erif.exe_MemtoReg    = drif.exe_MemtoReg;
  assign erif.exe_MemWr       = drif.exe_MemWr;
  assign erif.exe_MemRd       = drif.exe_MemRd;
  assign erif.exe_branch      = drif.exe_branch;
  assign erif.exe_PCSrc       = drif.exe_PCSrc;

  // data signal connections
  assign erif.exe_pc_4        = drif.exe_pc_4;
  assign erif.exe_jump_addr   = drif.exe_jump_addr << 2;
  assign erif.exe_branch_addr = (drif.exe_ex_out << 2) + drif.exe_pc_4;
  //assign erif.exe_rdat1       = drif.exe_rdat1;
  assign erif.exe_rdat1       = fuif.rdat1_out;
  assign erif.exe_ex_out      = drif.exe_ex_out;
  always_comb begin
    if (drif.exe_jal | drif.op_out == J) begin
      erif.exe_zero = 1'b0;
    end
    else begin
      erif.exe_zero = aluif.zero;
    end
  end // always_comb
  //assign erif.exe_zero        = drif.exe_jal ?  0 : aluif.zero;
  assign erif.exe_alu_out     = aluif.out;
  assign erif.exe_rdat2       = fuif.rdat2_out;
  assign erif.exe_wsel        = drif.exe_RegDst ? drif.exe_rd : (drif.exe_jal ? 32'd31 : drif.exe_rt );

  // ---------- Memory register and memory stage ---------- //
  assign mem_EN = hzif.mem_EN;
  always_ff @(posedge CLK, negedge nRST) begin
    // reset
    if(nRST == 1'b0) begin
      // control signals
       mrif.op_out <= RTYPE;
      mrif.wrb_halt     <= '0;
      mrif.wrb_RegWr    <= '0;
      mrif.wrb_MemtoReg <= '0;

      // data signals
      mrif.wrb_pc_4     <= '0;
      mrif.wrb_dmemload <= '0;
      mrif.wrb_ex_out   <= '0;
      mrif.wrb_alu_out  <= '0;
      mrif.wrb_wsel     <= '0;
    end

    // enabled
    else if (mem_EN == 1'b1) begin
      // control signals
       mrif.op_out <= mrif.op_in;
      mrif.wrb_halt     <= mrif.mem_halt;
      mrif.wrb_RegWr    <= mrif.mem_RegWr;
      mrif.wrb_MemtoReg <= mrif.mem_MemtoReg;

      // data signals
      mrif.wrb_pc_4     <= mrif.mem_pc_4;
      mrif.wrb_dmemload <= mrif.mem_dmemload;
      mrif.wrb_ex_out   <= mrif.mem_ex_out;
      mrif.wrb_alu_out  <= mrif.mem_alu_out;
      mrif.wrb_wsel     <= mrif.mem_wsel;
    end

    // disable, recycle latch outputs to inputs
    else begin
      // control signals
       mrif.op_out <= mrif.op_out;
      mrif.wrb_halt     <= mrif.wrb_halt;
      mrif.wrb_RegWr    <= mrif.wrb_RegWr;
      mrif.wrb_MemtoReg <= mrif.wrb_MemtoReg;

      // data signals
      mrif.wrb_pc_4     <= mrif.wrb_pc_4;
      mrif.wrb_dmemload <= mrif.wrb_dmemload;
      mrif.wrb_ex_out   <= mrif.wrb_ex_out;
      mrif.wrb_alu_out  <= mrif.wrb_alu_out;
      mrif.wrb_wsel     <= mrif.wrb_wsel;
    end
  end // alays_ff

  // control signal connections
   assign mrif.op_in = erif.op_out;
  assign mrif.mem_halt     = erif.mem_halt;
  assign mrif.mem_RegWr    = erif.mem_RegWr;
  assign mrif.mem_MemtoReg = erif.mem_MemtoReg;

  // data signal connections
  assign mrif.mem_pc_4     = erif.mem_pc_4;
  assign mrif.mem_dmemload = dpif.dmemload;
  assign mrif.mem_ex_out   = erif.mem_ex_out;
  assign mrif.mem_alu_out  = erif.mem_alu_out;
  assign mrif.mem_wsel     = erif.mem_wsel;


  // ---------- Buffer Latch for forwarding ------------- //


  // ########## PC increment logic and register ########## //

  // ---------- PC register ---------- //
  logic PCWE;
  assign PCWE = hzif.PCWE;
  always_ff @(posedge CLK, negedge nRST) begin
    // reset
    if(nRST == 1'b0) begin
      //pc <= 32'd0;
       pc <= PC_INIT;
       
    end
    // enabled
    else if (PCWE == 1'b1 & dpif.ihit & ~dpif.dhit) begin
        pc <= npc;
    end
    // disabled
    else begin
      pc <= pc;
    end
  end // always_ff

  // ---------- branch and jump logic ---------- //
  assign pc_4        = pc + 4;
  assign pc_register = erif.mem_rdat1;
  assign pc_branch   = erif.mem_branch_addr;
  assign pc_jump     = {pc_4[31:28], erif.mem_jump_addr};



  always_ff @ (posedge CLK, negedge nRST) begin

    if (nRST == 1'b0) begin
      //PCSrc <= 1'b0;
       PCSrc <= PC_INIT;
       
    end
    else begin
      PCSrc <= next_PCSrc;
    end
  end
  // ---------- PC increment logic ---------- //
  always_comb begin
    npc = 0;
    hzif.PCSrc = 2'b00;
    next_PCSrc  = PCSrc;
    // zero flag is not set, set next pc according to PCSrc
    if(erif.mem_zero == 2'b00) begin
      if          (erif.mem_PCSrc == 2'b00) begin
        npc = pc_4;
        hzif.PCSrc = 2'b00;
        next_PCSrc = 1'b1;
      end else if (erif.mem_PCSrc == 2'b01) begin
        npc = pc_register;
        hzif.PCSrc = 2'b01;
        next_PCSrc = 1'b0;
      end else if (erif.mem_PCSrc == 2'b10) begin
        npc = pc_branch;
        hzif.PCSrc = 2'b10;
        next_PCSrc = 1'b0;
      end else if (erif.mem_PCSrc == 2'b11) begin
        npc = pc_jump;
        hzif.PCSrc = 2'b11;
        next_PCSrc = 1'b0;
      end
    end
    // zero flag is set, choose between pc + 4 or branch
    else begin
      if(erif.mem_branch == 1'b0) begin
         npc = pc_4;
          hzif.PCSrc = 2'b00;
         next_PCSrc = 1'b1;
      end
      else begin
        npc = pc_branch;
        hzif.PCSrc = 2'b10;
        next_PCSrc = 1'b0;
      end
    end
  end // always_comb


  // ########## module glue logic ########## //

  // ----------  connect control unit ---------- //
  assign ctrluif.op[5:0]   = frif.decode_imemload[31:26];
  assign ctrluif.func = frif.decode_imemload[5:0];

  // ---------- connect register file ---------- //
  assign rfif.rsel1 = frif.decode_imemload[25:21];
  assign rfif.rsel2 = frif.decode_imemload[20:16];
  assign rfif.WEN   = mrif.wrb_RegWr;
  assign rfif.wsel  = mrif.wrb_wsel;
  // choose between alu output, extended immediate value, data from memory, or pc + 4  to write to register
  always_comb begin
    casez(mrif.wrb_MemtoReg)
      2'b00 : begin
        rfif.wdat = mrif.wrb_alu_out;
        fuif.wb_dat = mrif.wrb_alu_out;
      end
      2'b01 : begin
        rfif.wdat = mrif.wrb_ex_out;
        fuif.wb_dat = mrif.wrb_ex_out;
      end
      2'b10 : begin
        rfif.wdat = mrif.wrb_dmemload;
        fuif.wb_dat = mrif.wrb_dmemload;
      end
      2'b11 : begin
        rfif.wdat = mrif.wrb_pc_4;
        fuif.wb_dat = mrif.wrb_pc_4;
      end
    endcase
  end // always_comb

  // ---------- connect alu ---------- //
  assign aluif.ALUOP = drif.exe_ALUOp;
  assign aluif.porta = fuif.rdat1_out;
  assign aluif.portb = drif.exe_shift ? {27'd0, drif.exe_shamt} : (drif.exe_ALUSrc ? drif.exe_ex_out : fuif.rdat2_out);

  // ---------- connect hazard unit ---------- //
  assign hzif.MemWr = erif.mem_MemWr;
  assign hzif.MemRd = erif.mem_MemRd;
  assign hzif.ihit  = dpif.ihit;
  assign hzif.dhit  = dpif.dhit;
  assign hzif.exe_wsel  = erif.exe_wsel;
  assign hzif.mem_wsel  = erif.mem_wsel;
  assign hzif.rs = frif.decode_imemload[25:21];
  assign hzif.rt = frif.decode_imemload[20:16];

   //-----------forward unit---------------//
   assign fuif.ex_rsel1 = drif.exe_rs;
   assign fuif.ex_rsel2 = drif.exe_rt;
   assign fuif.ex_rdat1 = drif.exe_rdat1;
   assign fuif.ex_rdat2 = drif.exe_rdat2;
   assign fuif.mem_wsel = erif.mem_wsel;
   assign fuif.mem_dat  = erif.mem_MemRd ? dpif.dmemload : erif.mem_alu_out;
   assign fuif.wb_wsel  = mrif.wrb_wsel;
   //assign fuif.wb_dat   = mfif.wdat;
   assign fuif.memToReg = mrif.wrb_MemtoReg;
   assign fuif.mem_wen  = erif.mem_RegWr;
   assign fuif.wb_wen   = mrif.wrb_RegWr;


  // ---------- attach datapath ---------- //
  assign dpif.halt      = mrif.mem_halt;
  assign dpif.imemREN   = !(erif.mem_MemRd || erif.mem_MemWr) && !erif.mem_halt;
  assign dpif.imemaddr  = pc;
  assign dpif.dmemREN   = erif.mem_MemRd;
  assign dpif.dmemWEN   = erif.mem_MemWr;
  assign dpif.dmemstore = erif.mem_rdat2;
  assign dpif.dmemaddr  = erif.mem_alu_out;

  // ---------- attach caches to datapath ---------- //



  // ---------- attach caches to memory controller ---------- //

endmodule
