class fifo_scoreboard;
   
	wr_tx wtx;
	rd_tx rtx;

   function new();
	endfunction


	task run();
	   $display("Inside Run task of FIFO Scoreboard class");
		forever begin
		    wtx = new();
			 rtx = new();
			 wr_mon2sco.get(wtx);
			 rd_mon2sco.get(rtx);
			 if(wtx.wdata == rtx.rdata)begin
			     fifo_common::num_matches++;
			 end
			 else begin
			     fifo_common::num_mismatches++;
			 end
		end
	endtask

endclass