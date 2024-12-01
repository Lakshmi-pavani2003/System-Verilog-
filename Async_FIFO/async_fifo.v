module async_fifo(wr_clk_i,rd_clk_i, rst_i, wr_en_i, rd_en_i, wdata_i, rdata_o, full_o, empty_o, overflow_o, underflow_o);
  
  parameter WIDTH = 16;
  parameter DEPTH = 16;
  
  input wr_clk_i,rd_clk_i,rst_i, wr_en_i, rd_en_i;
  input [WIDTH-1:0] wdata_i;
  output reg [WIDTH-1:0] rdata_o;
  output reg full_o, empty_o, underflow_o, overflow_o;

  //creating Memory 
  //Internal Singals
  reg [WIDTH-1:0]mem[DEPTH-1:0];
  reg [3:0] wr_ptr, rd_ptr;
  reg wr_toggle_f, rd_toggle_f;

  reg [3:0]wr_ptr_r,rd_ptr_w;
  reg wr_toggle_r, rd_toggle_w;
  integer i;


  //write operation 
  always@(posedge wr_clk_i or posedge rst_i)begin
    if(rst_i == 1)begin
       full_o = 0;
       overflow_o = 0;
       wr_ptr = 0;
       wr_toggle_f = 0;
       rdata_o = 0;
       empty_o = 1;
       underflow_o = 0;
       rd_ptr = 0;
       rd_toggle_f = 0;
       for(i=0; i<DEPTH; i=i+1) mem[i]=0; 
    end
    else begin
      overflow_o = 0;
      
      if(wr_en_i ==1)begin
         if(full_o ==1)begin
            overflow_o = 1;
         end
         else begin
         mem[wr_ptr] = wdata_i;
         if(wr_ptr == DEPTH-1) wr_toggle_f = ~wr_toggle_f;
         wr_ptr = wr_ptr+1;
         end
      end
    end
  end


  //Read operation
  always@(posedge rd_clk_i or posedge rst_i)begin
    if(rst_i==0)begin
    //   for(i = 0; i<DEPTH; i=i+1) mem[i] =0;
    //end
    //else begin
      // underflow_o = 0;
       underflow_o = 0;
       if(rd_en_i == 1)begin
          if(empty_o == 1)begin
            underflow_o = 1;
          end
          else begin
             rdata_o = mem[rd_ptr];
             if(rd_ptr == DEPTH-1) rd_toggle_f = ~rd_toggle_f;
             rd_ptr = rd_ptr+1;
          end
       end
    end
  end

  //synchronous for write

  always@(posedge rd_clk_i or posedge rst_i)
  begin
     if(rst_i == 1)begin
       wr_ptr_r <= 0;
       wr_toggle_r <=0;
     end
     else begin
       wr_ptr_r <= wr_ptr;
       wr_toggle_r <= wr_toggle_f;
     end
  end

  //synchronous for read
  always@(posedge wr_clk_i or posedge rst_i)
  begin
    if(rst_i == 1)begin
        rd_ptr_w <= 0;
        rd_toggle_w <=0;
     end
     else begin
        rd_ptr_w <= rd_ptr;
        rd_toggle_w <= rd_toggle_f;
     end
  end
  //Check for full and empty
  always@(*)begin
    empty_o = 0;
    full_o = 0;
    if(wr_ptr_r == rd_ptr && wr_toggle_r == rd_toggle_f) empty_o = 1;
    if(wr_ptr == rd_ptr_w && wr_toggle_f != rd_toggle_w) full_o = 1;
  end
 
  
endmodule