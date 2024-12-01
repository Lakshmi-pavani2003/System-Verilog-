interface fifo_intf(input reg wr_clk_i,rd_clk_i,rst_i);

   logic wr_en_i,rd_en_i;
	logic [WIDTH-1:0]wdata_i;
	logic [WIDTH-1:0]rdata_o;
	logic full_o, empty_o, overflow_o, underflow_o;

	clocking wr_mon_cb@(posedge wr_clk_i);
	    default input #0;
		 input wr_en_i;
		 input wdata_i;
		 input full_o,overflow_o;
	endclocking
endinterface