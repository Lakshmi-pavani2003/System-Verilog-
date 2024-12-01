`timescale 1ns/1ns

parameter WIDTH = 16;
parameter DEPTH = 16;

mailbox wr_gen2drv = new();
mailbox rd_gen2drv = new();
mailbox wr_mon2cov = new();
mailbox wr_mon2sco = new();
mailbox rd_mon2cov = new();
mailbox rd_mon2sco = new();
event e;

class fifo_common;
   static string testcase="test_wr_rd";
	static int wr_count = 20;
	static int rd_count = 20;
	static int drv_count;
	static int num_matches;
	static int num_mismatches;
endclass