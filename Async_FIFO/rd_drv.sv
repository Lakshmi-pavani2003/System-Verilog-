class rd_drv;
   rd_tx tx;
	virtual fifo_intf vif;
   function new();
	    vif = top.pif;
	endfunction


	task run();
	   $display("Inside Run task of FIFO Read Driver class");
		forever begin
		    tx = new();
			 rd_gen2drv.get(tx);
			 drive_tx(tx);
			 //tx.print("RD_DRV");
		end
	endtask

	task drive_tx(rd_tx tx);
	  // $display("Inside Driver transaction task of FIFO Write Driver class");
	   @(negedge vif.rd_clk_i);
		vif.rd_en_i = tx.rd_en;
		@(negedge vif.rd_clk_i);
		vif.rd_en_i = 0;
		tx.empty = vif.empty_o;
		tx.underflow = vif.underflow_o;
		tx.rdata = vif.rdata_o;
	endtask
endclass
