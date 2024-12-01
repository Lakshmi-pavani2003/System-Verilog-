class fifo_rd_agent;

  rd_gen gen;
  rd_drv drv;
  rd_mon mon;
  rd_cov cov;


  function new();
     gen = new();
	  drv = new();
	  mon = new();
	  cov = new();
  endfunction


  task run();
     $display("Inside Run task of FIFO Read Agent class");
	  fork
	    gen.run();
		 drv.run();
		 mon.run();
		 cov.run();

	  join
  endtask
endclass

