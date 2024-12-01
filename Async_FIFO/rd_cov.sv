class rd_cov;
    
    rd_tx tx;
	 covergroup rd_cg;

	   RD_EN_CP:coverpoint tx.rd_en
		{
		    bins READS = {1'b1};
			 ignore_bins ignore_vlaue ={1'b0};
		}
	   EMPTY_CP:coverpoint tx.empty
		{
		    bins EMPTY = {1'b1};
			 bins NOT_EMPTY ={1'b0};
		}
	   UNDERFLOW_CP:coverpoint tx.underflow
		{
		    bins UNDERFLOW = {1'b1};
			 bins NOT_UNERFLOW ={1'b0};
		}
    endgroup
	 function new();
	    rd_cg = new();
	 endfunction


	 task run();
	     $display("Inside Run task of FIFO Read Coverage class");
		  forever begin
		     tx = new();
			  rd_mon2cov.get(tx);
			  rd_cg.sample();
		  end
	 endtask
endclass
