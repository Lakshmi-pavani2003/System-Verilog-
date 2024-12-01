class rd_tx;
  rand logic rd_en;
  rand logic [WIDTH-1:0]rdata;
       logic empty;
		 logic underflow;

  function void print(string name = "RD_TX");
     $display("## %0s @ %0t ##\trdata=%0h\trd_en=%0b\tempty=%0b\tUnderflow=%0b",name,$time,rdata,rd_en,empty,underflow);
  endfunction
endclass
