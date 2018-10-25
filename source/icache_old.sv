
`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"

module icache(

	input logic CLK, nRST,
	datapath_cache_if.icache dcif,
	caches_if.icache cif

);

import cpu_types_pkg::*;


typedef struct packed{
	logic valid;
	logic [25:0] tag;
	word_t data;

} icache_frame;

typedef enum {
	IDLE,
	WAIT
} cacheState;

//512 bits = 16 words

icache_frame [15:0] i_cache; //16 entry direct mapped cache
icache_frame [15:0] next_i_cache; // 16 entry direct mapped cache

cacheState state;
cacheState next_state;

logic cache_hit;
//, next_cache_hit;
logic ram_hit;

icachef_t mem_addr;

word_t addr;

assign mem_addr = dcif.imemaddr;
assign addr = dcif.imemaddr;
//assign dcif.ihit = cache_hit;

always_ff @(posedge CLK, negedge nRST) begin
	if(nRST == 0) begin
		i_cache <= '{default: '0};
		state <= IDLE;
    //cache_hit <= 1'b0;
	end
	else begin
		i_cache <= next_i_cache;
		state <= next_state;
    //cache_hit <= next_cache_hit;
	end
end

always_comb begin

	//default values

	//next_cache_hit = '0;
	//ram_hit = '0;
	dcif.imemload = '0;
       dcif.ihit = '0;

	cif.iREN = '0;
	cif.iaddr = '0;
	next_state = state;
	next_i_cache = i_cache;

	casez(state)
		IDLE:
		begin
			//check the address tag valid bit and make sure iREN is asserted
			if(i_cache[mem_addr.idx].tag == mem_addr.tag & i_cache[mem_addr.idx].valid & dcif.imemREN)
			begin
				//Memory is in the cache
				dcif.imemload = i_cache[mem_addr.idx].data;
				next_state = IDLE;
				dcif.ihit = 1'b1;
			  cache_hit = '1;
			end
			//cache miss
			else if(dcif.imemREN)
			begin
				cache_hit = '0;
				next_state = WAIT;
        next_i_cache[mem_addr.idx].tag = mem_addr.tag;
			end
			else
			//nothing
			begin
				next_state = IDLE;
			end
		end
		WAIT:
		begin
			cif.iREN = '1;
			cif.iaddr = dcif.imemaddr;

			if(!cif.iwait)
				begin
				ram_hit = '1;
				next_i_cache[mem_addr.idx].valid = '1;
				//next_i_cache[mem_addr.idx].tag = mem_addr.tag;
				next_i_cache[mem_addr.idx].data = cif.iload;
				dcif.imemload = cif.iload;
				next_state = IDLE;
			end
		end

	endcase



end




endmodule


