/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  logic rec, req, next_rec, next_req;
  logic icache_lru, next_icache_lru;

  typedef enum {IDLE, ICACHE_ARB, ICACHE_LOAD,ARBITRATE, SNOOP, READ_CACHE1, READ_CACHE2, READ1, READ2, WRITE1, WRITE2, WB1, WB2} State;
  State state, next_state;

  always_ff @(negedge nRST, posedge CLK) begin
    if(nRST == 1'b0) begin
      state <= IDLE;
       rec <= '0;
       req <= '1;
       icache_lru <= '0;
       //ccif.ccwait[0] <= 0;
       //ccif.ccwait[1] <= 0;
    end
    else begin
      state <= next_state;
      rec <= next_rec;
      req <= next_req;
      icache_lru <= next_icache_lru;

    end
  end // always_ff



  always_comb begin
     //caches
     ccif.iload[0] = '0;
     ccif.iload[1] = '0;
     ccif.iwait[0] = '1;
     ccif.iwait[1] = '1;

     ccif.dload[0] = '0;
     ccif.dload[1] = '0;
     ccif.dwait[0] = '0;
     ccif.dwait[1] = '0;

     //coherence
     ccif.ramstore = '0;
     ccif.ccinv = '0;
     ccif.ccsnoopaddr = '0;
     ccif.ccwait = '0;
     //ram
     ccif.ramWEN = '0;
     ccif.ramREN = '0;
     ccif.ramstore = '0;
     ccif.ramaddr = '0;


     //states
     next_state = state;
     next_rec = rec;
     next_req = req;
     next_icache_lru = icache_lru;

     casez(state)
       IDLE: begin

	  if(ccif.cctrans[0]) begin

       //ccif.dwait[0] = 1'b1;
       //ccif.dwait[0] = 1;
	     next_req = 0;
	     next_rec = 1;

	     next_state = ARBITRATE;

	     end
	  else if(ccif.cctrans[1]) begin
	     //ccif.dwait[1] = 1;
       next_req = 1;
	     next_rec = 0;
	     next_state = ARBITRATE;
	     end
	  else if( (ccif.iREN[0] && !ccif.dREN[0]) || (ccif.iREN[1] && !ccif.dREN[1]))
	    begin
	       next_state = ICACHE_ARB;
	    end
       end

       ICACHE_ARB: begin
	   if (ccif.iREN[0] && !ccif.dREN[0] &&  icache_lru == '0) begin
	     next_req = 0;
	     next_rec = '1;
      ccif.dwait[1] = 1'b1;
	     next_state = ICACHE_LOAD;
       next_icache_lru = 1;


    end
	  else if (ccif.iREN[0] && !ccif.dREN[0] &&  icache_lru == '1 && !(ccif.iREN[1] && !ccif.dREN[1])) begin
       next_req = 0;
	     next_rec = '1;
      ccif.dwait[1] = 1'b1;
	     next_state = ICACHE_LOAD;
       next_icache_lru = 1;
    end
	  else if (ccif.iREN[1] && !ccif.dREN[1] &&  icache_lru == '0 && !(ccif.iREN[0] && !ccif.dREN[0])) begin
	     next_req = 1;
	     next_rec = '0;
      ccif.dwait[0] = 1'b1;
       next_icache_lru = 0;
	     next_state = ICACHE_LOAD;
    end
	  else begin
	     next_req = 1;
	     next_rec = '0;
      ccif.dwait[0] = 1'b1;
       next_icache_lru = 0;
	     next_state = ICACHE_LOAD;
	  end
	 //ccif. ccwait[rec] = 1'b1;
       end // case: ICACHE_ARB

       ICACHE_LOAD: begin
	  ccif.ramREN = 1;
	  ccif.ramWEN = 0;
	  ccif.ramaddr = ccif.iaddr[req];
    // ccif.ccwait[rec] = 1'b1;
    ccif.dwait[rec] = 1'b1;
	  if(ccif.ramstate == ACCESS) begin
	     ccif.iload[req] = ccif.ramload;
	     next_state = IDLE;
	     ccif.iwait[req] = '0;

	  end

       end

ARBITRATE: begin

	  ccif.dwait[req] = 1;
	  ccif.ccwait[rec] = 1;

	  if(ccif.dWEN[req]) begin
	     next_state = WB1;
	  end
	  else begin
	     next_state = SNOOP;
	  end



	  end
       SNOOP: begin
	  ccif.dwait[req] = 1;
	  //ccif.ccwait[req] = 1;
	  ccif.ccsnoopaddr[rec] = ccif.daddr[req];
	  ccif.ccwait[rec] = 1;

	  if(!ccif.ccwrite[rec] & ccif.cctrans[rec]) begin
	     next_state = READ1;
	  end
	  else if(ccif.ccwrite[rec] & ccif.cctrans[rec]) begin
	     next_state = WRITE1;
	  end
	  else if(!ccif.ccwrite[rec] & !ccif.cctrans[rec]) begin
	     next_state = READ_CACHE1;

	  end
    end

       READ_CACHE1: begin
	  ccif.dwait[req] = '0;
	  ccif.dload[req] = ccif.dstore[rec];
    ccif.ccwait[rec] = 1'b1;
	  ccif.ccsnoopaddr[rec] = ccif.daddr[req];
    ccif.ccinv[rec] = ccif.ccwrite[req];
	  next_state = READ_CACHE2;
       end

       READ_CACHE2: begin
	  ccif.dwait[req] = '0;
	  ccif.dload[req] = ccif.dstore[rec];
    ccif.ccwait[rec] = 1'b1;
	  ccif.ccsnoopaddr[rec] = ccif.daddr[req];
    ccif.ccinv[rec] = ccif.ccwrite[req];
	  next_state =  IDLE;

	  end


       READ1: begin
	  ccif.dwait[req] = 1;
	  ccif.dload[req] = ccif.ramload;
	  ccif.ramREN = 1;
	  ccif.ramWEN = 0;
	  //ramif.ramaddr = ccif.daddr[req];
	  ccif.ramaddr = ccif.daddr[req];
	  ccif.ccwait[rec] = 1;
	  ccif.ramstore = '0;

	  if(ccif.ramstate == ACCESS) begin
	     ccif.dwait[req] = 0;
	     next_state = READ2;

	     end
	  end
       READ2: begin
	  ccif.dwait[req] = 1;
	  ccif.dload[req] = ccif.ramload;
	  ccif.ramREN = 1;
	  ccif.ramWEN = 0;
	  //ramif.ramaddr = ccif.daddr[req];
	  ccif.ramaddr = ccif.daddr[req];
	  ccif.ccwait[rec] = 1;
	  ccif.ramstore = '0;
    ccif.ccinv[rec] = ccif.ccwrite[req];
	  if(ccif.ramstate == ACCESS) begin
	     ccif.dwait[req] = 0;
	     next_state = IDLE;

	     end
	  end
       WRITE1: begin
	  ccif.dwait[rec] = 1;
	  ccif.dwait[req] = 1;
    ccif.ccwait[rec] = 1;
	  //ccif.dload[rec] = ccif.ramload;
	  ccif.ramREN = 0;
	  ccif.ramWEN = 1;
	  ccif.ramaddr =  ccif.daddr[rec];
	  ccif.ramstore = ccif.dstore[rec];
    ccif.ccsnoopaddr[rec] = ccif.daddr[req];
	  ccif.dload[req] = ccif.dstore[rec];


	  if(ccif.ramstate == ACCESS) begin
	     ccif.dwait[req] = 0;
	     ccif.dwait[rec] = 0;
	     //ccif.dwait[rec] = 0;
	     next_state = WRITE2;

	     end
	  end
       WRITE2: begin
	  ccif.dwait[rec] = 1;
	  ccif.dwait[req] = 1;
	  //ccif.dload[rec] = ccif.ramload;
	  ccif.ramREN = 0;
	  ccif.ramWEN = 1;
	  ccif.ramaddr = ccif.daddr[rec];
	  ccif.ccwait[rec] = 1;
	  ccif.ramstore = ccif.dstore[rec];
    ccif.ccinv[rec] = ccif.ccwrite[req];

	  ccif.dload[req] = ccif.dstore[rec];
	  ccif.ccsnoopaddr[rec] = ccif.daddr[req];


	  if(ccif.ramstate == ACCESS) begin
	     ccif.dwait[req] = 0;
	     ccif.dwait[rec] = 0;
	     next_state = IDLE;
	     end
	  end
       WB1: begin
	  ccif.dwait[req] = 1;
	  ccif.ramREN = 0;
	  ccif.ramWEN = 1;
	  ccif.ramaddr = ccif.daddr[req];
	  ccif.ccwait[rec] = 1;
	  ccif.ramstore = ccif.dstore[req];

	  if(ccif.ramstate == ACCESS) begin
	     ccif.dwait[req] = 0;
	     next_state = WB2;
	     end

	  end
       WB2: begin
	  ccif.dwait[req] = 1;
	  ccif.ramREN = 0;
	  ccif.ramWEN = 1;
	  ccif.ramaddr = ccif.daddr[req];
	  ccif.ccwait[rec] = 1;
	  ccif.ramstore = ccif.dstore[req];

	  if(ccif.ramstate == ACCESS && ccif.dWEN[req] == 1'b0) begin
	     ccif.dwait[req] = 0;
	     next_state = READ1;
	     end
    else if(ccif.ramstate == ACCESS && ccif.dWEN[req] == 1'b1) begin
	     next_state = IDLE;
       ccif.dwait[req] = 0;
    end

           end

  endcase
  end // always_comb


  /*
  // aissign cache outputs
  assign ccif.iload = (ccif.iREN == 1'b1 & ccif.iwait == 1'b0) ? ccif.ramload : 32'd0;
  assign ccif.dload = ccif.ramload;

  // assign ram outputs
  assign ccif.ramstore = ccif.dstore;
  assign ccif.ramaddr  = ((ccif.dREN == 1'b1) || (ccif.dWEN == 1'b1)) ? ccif.daddr : ccif.iaddr;
  assign ccif.ramWEN   = ccif.dWEN;
  assign ccif.ramREN   = ((ccif.dREN == 1'b1 || ccif.iREN == 1'b1) && ccif.dWEN == 1'b0) ? 1'b1 : 1'b0;

  // wait signal logic
  always_comb begin
    if (ccif.ramstate == ACCESS) begin
      if (ccif.iREN == 1 && ccif.dWEN == 1'b0 && ccif.dREN == 1'b0) begin
        ccif.iwait = 1'b0;
      end else begin
        ccif.iwait = 1'b1;
      end
    end else begin
      ccif.iwait = 1'b1;
    end

    if (ccif.ramstate == ACCESS) begin
      if (ccif.dREN == 1'b1) begin
        ccif.dwait = 1'b0;
      end else begin
        if (ccif.dWEN == 1'b1) begin
          ccif.dwait = 1'b0;
        end else begin
          ccif.dwait = 1'b1;
        end
      end
    end else begin
      ccif.dwait = 1'b1;
    end
  end // always_comb
  */

endmodule
