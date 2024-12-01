class fifo_wr_agent;

  wr_gen gen;
  wr_drv drv;
  wr_mon mon;
  wr_cov cov;


  function new();
     gen = new();
	  drv = new();
	  mon = new();
	  cov = new();
  endfunction


  task run();
     $display("Inside Run task of FIFO Write Agent class");
	  fork
	    gen.run();
		 drv.run();
		 mon.run();
		 cov.run();

	  join
  endtask
endclass
