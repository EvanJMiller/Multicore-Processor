
`include "cpu_types_pkg.vh"
`include "forward_unit_if.vh"

module forward_unit  (
    forward_unit_if fuif
);

import cpu_types_pkg::*;
 

always_comb
  begin
     fuif.rdat1_out = fuif.ex_rdat1;
     fuif.rdat2_out = fuif.ex_rdat2;

     //--------------rSel1------------------------------------------------------------
     //data in the mem stage needed in the execute stage
     if ((fuif.ex_rsel1 == fuif.mem_wsel) & (fuif.mem_wsel != '0) & (fuif.memToReg == '0) & fuif.mem_wen)
       begin
	  fuif.rdat1_out = fuif.mem_dat;
       end
     //data in the write back needed in the execute stage	  
     else if((fuif.ex_rsel1 == fuif.wb_wsel) & (fuif.wb_wsel != '0) & fuif.wb_wen)
       begin
	  fuif.rdat1_out = fuif.wb_dat;
       end

     //--------------rSel2--------------------------------------
     //data in the mem stage needed in the execute stage
     if ((fuif.ex_rsel2 == fuif.mem_wsel) & (fuif.mem_wsel != '0) & (fuif.memToReg == '0) & fuif.mem_wen)
       begin
	  fuif.rdat2_out = fuif.mem_dat;
       end
     //data in the write back needed in the execute stage	  
     else if((fuif.ex_rsel2 == fuif.wb_wsel) & (fuif.wb_wsel != '0) & fuif.wb_wen)
       begin
	  fuif.rdat2_out = fuif.wb_dat;
       end
     
end  

endmodule   
