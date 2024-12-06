mailbox mon2sco = new();


class apb_env;
	
	apb_agent agent;
	scoreboard sco;

	function new();
		agent=new();
		sco = new();
	endfunction

	task run();
		agent.run();
		sco.run();
	endtask

endclass
