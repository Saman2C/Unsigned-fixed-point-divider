module divider(a_in, b_in, start, sclr, clk, q_out, dvz, ovf, busy, valid);
  input [9:0] a_in, b_in;
  input start, sclr, clk;
  output wire [9:0] q_out;
  output wire busy, valid;
  output wire dvz, ovf;
  
  wire co, ld_a, ld_b, ld_acc, ld_q, init_counter, sel_q, sel_acc, count_up;
  controller controll(start, co, dvz, ovf, clk, rst, ld_a, ld_b, ld_acc, ld_q, init_counter, sel_q, sel_acc, busy, valid, count_up);
  datapath dp(a_in, b_in, ld_a, ld_b, ld_q, ld_acc, sel_q, sel_acc, count_up, init_counter, clk, sclr, q_out, ovf, dvz, co);
  
endmodule