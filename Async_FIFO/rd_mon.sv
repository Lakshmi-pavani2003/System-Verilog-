class rd_mon;
   rd_tx tx;
   virtual fifo_intf vif;
	function new();
	   vif = top.pif;
	endfunction


	task run();
	  $display("Inside Run task of FIFO Read Monitor class");
	  forever begin
	     @(negedge vif.rd_clk_i)
		  if(vif.rd_en_i == 1)begin
		     tx = new();
		     tx.rd_en = vif.rd_en_i;
           tx.empty = vif.empty_o;
			  tx.underflow = vif.underflow_o;
			  tx.rdata = vif.rdata_o;
			  rd_mon2cov.put(tx);
			  rd_mon2sco.put(tx);
			  tx.print("RD_MON");
		  end
	  end
	endtask
endclass
