class rd_gen;
  rd_tx tx;
  function new();
  endfunction

  task run();
    $display("Inside Run task of FIFO Read Generator class");
	 if(fifo_common::testcase == "test_wr_rd")begin
	    wait(e.triggered);
	 end
	 case(fifo_common::testcase)
	   "test_rd":begin
		   read(fifo_common::rd_count);
		end
	   "test_wr_rd":begin
		   read(fifo_common::rd_count);
		end
	   "test_empty":begin
		   read(fifo_common::wr_count);
		end
	   "test_underflow":begin
		   read(fifo_common::wr_count);
		end
	 endcase
  endtask

  task read(int count);
         repeat(count)begin
			tx=new();
			tx.randomize() with {tx.rd_en==1;};
			rd_gen2drv.put(tx);
			end
  endtask
endclass

