class wr_drv;

   virtual fifo_intf vif;
   wr_tx tx;
   function new();
	   vif = top.pif;
	endfunction


	task run();
	   $display("Inside Run task of FIFO Write Driver class");
		forever begin
		    tx = new();
			 wr_gen2drv.get(tx);
			 drive_tx(tx);
			 fifo_common::drv_count++;
			 //tx.print("WR_DRV");
			 if(fifo_common::drv_count==fifo_common::wr_count) -> e;
		end
	endtask

	task drive_tx(wr_tx tx);
	  // $display("Inside Driver transaction task of FIFO Write Driver class");
	   @(negedge vif.wr_clk_i);
	   vif.wr_en_i = tx.wr_en;
	   vif.wdata_i = tx.wdata;
	   @(negedge vif.wr_clk_i);
	   vif.wr_en_i = 0;
	   vif.wdata_i = 0;
		tx.full = vif.full_o;
		tx.overflow = vif.overflow_o;
	endtask
endclass
