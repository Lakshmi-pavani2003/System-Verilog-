class fifo_env;

  fifo_wr_agent wr_agent;
  fifo_rd_agent rd_agent;
  fifo_scoreboard sco;

  function new();
     wr_agent = new();
	  rd_agent = new();
	  sco      = new();
  endfunction


  task run();
    $display("Inside Run task of FIFO Environment Class");
    fork
	   wr_agent.run();
		rd_agent.run();
		sco.run();
	 join
  endtask
endclass