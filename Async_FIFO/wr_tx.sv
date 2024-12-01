class wr_tx;
  rand logic wr_en;
  rand logic [WIDTH-1:0]wdata;
       logic full;
		 logic overflow;

  function void print(string name = "WR_TX");
     $display("## %0s @ %0t ##\twdata=%0h\twr_en=%0b\tfull=%0b\tOverflow=%0b",name,$time,wdata,wr_en,full,overflow);
  endfunction
endclass
