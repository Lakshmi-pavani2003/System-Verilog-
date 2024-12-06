class scoreboard;
    apb_tx tx;
	
	bit [`WIDTH-1:0] pwdata_i=0;
	bit [`WIDTH-1:0] prdata_o;
	
	task run();
	    forever begin
		$display("scoreboard");
		    tx = new();
            mon2sco.get(tx);
			if((tx.pwrite_i == 1'b1) &&(tx.pslverr_o)) begin   
			    pwdata_i[tx.paddr_i] = tx.pwdata_i;
				$display("[SCO]: Address: %0h and Data: %0d",tx.paddr_i, tx.pwdata_i);
			end
			else if((tx.pwrite_i == 1'b0) &&(tx.pslverr_o)) begin
			    prdata_o = pwdata_i[tx.paddr_i];
				if(tx.prdata_o == prdata_o)
				    $display("[SCO]: DATA Matched");
				else 
				    $display("[SCO]: DATA is Mismathed");
			end
			else if(tx.pslverr_o == 1'b1)
			    $display("[SCO]: SLAVE Error Detected");
			
		end
	endtask
endclass