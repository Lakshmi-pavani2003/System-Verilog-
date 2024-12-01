module top;
//clock and reset generation
//DUT instantiation
//Interface Instantiation
//Environment Instantiation and starting the environment.

  reg wr_clk, rd_clk,rst;

  fifo_intf pif(wr_clk, rd_clk, rst);

  
  async_fifo dut(
         .wr_clk_i(pif.wr_clk_i),
			.rd_clk_i(pif.rd_clk_i), 
			.rst_i(pif.rst_i), 
			.wr_en_i(pif.wr_en_i), 
			.rd_en_i(pif.rd_en_i), 
			.wdata_i(pif.wdata_i), 
			.rdata_o(pif.rdata_o), 
			.full_o(pif.full_o), 
			.empty_o(pif.empty_o), 
			.overflow_o(pif.overflow_o), 
			.underflow_o(pif.underflow_o)
			);
  


  fifo_env env;
  always #5 wr_clk = ~wr_clk;
  always #5 rd_clk = ~rd_clk;

  initial begin
     wr_clk = 0;
	  rd_clk = 0;
	  rst = 1;

	  reset();
	  repeat(2)@(posedge wr_clk);
	  rst = 0;

	  env = new();
	  env.run();
  end


  task reset();
     pif.wr_en_i = 0;
     pif.rd_en_i = 0;
	  pif.wdata_i = 0;
  endtask


  initial begin
     $fsdbDumpfile("async_fifo.fsdb");
	  $fsdbDumpvars(0,top);
  end

  initial begin
    #1000;
	 if(fifo_common::num_matches == 0 && fifo_common::num_mismatches == !0)begin
	     $display("Test Falied: Matches=%0d\tMisMatches=%0d",fifo_common::num_matches,fifo_common::num_mismatches);
	 end
	 else begin
	     $display("Test Passed: Matches=%0d\tMisMatches=%0d",fifo_common::num_matches,fifo_common::num_mismatches);
	 end
	 #50 $finish;
  end
   
endmodule
