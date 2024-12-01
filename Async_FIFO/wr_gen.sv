class wr_gen;
   
  wr_tx tx;
  function new();
  endfunction


  task run();
    $display("Inside Run task of FIFO Write Generator class");
	 case(apb_common::testcase)
	   "test_wr":begin
		   write(apb_common::wr_count);
		end
	   "test_wr_rd":begin
		   write(apb_common::wr_count);
		end
	   "test_full":begin
		   write(apb_common::wr_count);
		end
	   "test_overflow":begin
		   write(apb_common::wr_count);
		end
	 endcase
  endtask

  task write(int count);
         repeat(count)begin
			tx=new();
			tx.randomize() with {tx.wr_en==1;};
			wr_gen2drv.put(tx);
			end
  endtask
endclass
