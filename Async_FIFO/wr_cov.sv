class wr_cov;
    wr_tx tx;
	 covergroup wr_cg;

	   WR_EN_CP:coverpoint tx.wr_en
		{
		    bins WRITE = {1'b1};
			 ignore_bins ignore_vlaue ={1'b0};
		}
	   FULL_CP:coverpoint tx.full
		{
		    bins FULL = {1'b1};
			 bins NOT_FULL ={1'b0};
		}
	   OVERFLOW_CP:coverpoint tx.overflow
		{
		    bins OVERFLOW = {1'b1};
			 bins NOT_OVERFLOW ={1'b0};
		}
    endgroup
	 function new();
	   wr_cg = new();
	 endfunction


	 task run();
	     $display("Inside Run task of FIFO Write Coverage class");
		  forever begin
		     tx = new();
			  wr_mon2cov.get(tx);
			  wr_cg.sample();
		  end
	 endtask
endclass
