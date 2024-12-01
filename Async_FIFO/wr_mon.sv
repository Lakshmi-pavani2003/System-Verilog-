class wr_mon;
   wr_tx tx;
   virtual fifo_intf vif;
	function new();
	   vif = top.pif;
	endfunction


	task run();
	  $display("Inside Run task of FIFO Write Monitor class");
	  forever begin
	     @(vif.wr_mon_cb);
		  if(vif.wr_mon_cb.wr_en_i == 1)begin
		      tx= new();
		      tx.wr_en = vif.wr_mon_cb.wr_en_i;
				tx.wdata = vif.wr_mon_cb.wdata_i;
				tx.full = vif.wr_mon_cb.full_o;
				tx.overflow = vif.wr_mon_cb.overflow_o;
				wr_mon2cov.put(tx);
				wr_mon2sco.put(tx);
				tx.print("WR_MON");
		  end
	  end
	endtask
endclass
