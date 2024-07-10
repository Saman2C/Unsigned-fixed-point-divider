module datapath(a_in, b_in, ld_a, ld_b, ld_q, ld_acc, sel_q, sel_acc, cnt_up, init_counter, clk, rst, q, ovf, dvz, cout);
  input [9:0] a_in, b_in;
  input ld_a, ld_b, ld_q, ld_acc, sel_q, sel_acc, cnt_up, init_counter, clk, rst;
  output [9:0] q;
  output reg ovf, dvz;
  output cout;
  wire [9:0] a, b;
  wire [10:0] acc_in, acc;
  wire [9:0] q_in;
  wire sel_comparator;
  wire [10:0] sub_out;
  wire [3:0] i;
  wire [10:0] nxt_acc;
  wire [9:0] nxt_q;
  
  register #10 reg_a(a_in, ld_a, clk, rst, a);
  register #10 reg_b(b_in, ld_b, clk, rst, b);
  register #11 reg_acc(acc_in, ld_acc, clk, rst, acc);
  register #10 reg_q(q_in, ld_q, clk, rst, q);
  
  comparator comp(acc, {1'b0, b}, sel_comparator);
  subtractor sub(acc, {1'b0, b}, sub_out);
  counter_4_bit counter(cnt_up, init_counter, clk, rst, 4'b0010, i, cout);
  mux_2_to_1 #11 mux1(acc, sub_out, sel_comparator, nxt_acc);
  mux_2_to_1 #1 mux2(1'b0, 1'b1, sel_comparator, concat_q);
  mux_2_to_1 #10 mux3(nxt_q, {a[8:0], 1'b0}, sel_q, q_in);
  mux_2_to_1 #11 mux4({nxt_acc[9:0], q[9]}, {10'b0, a[9]}, sel_acc, acc_in);
  
  assign nxt_q = {q[8:0] , concat_q};
  assign ovf = ((i == 4'b1011 & nxt_q[9:4] == 6'b0) ? 1 : 0);
  assign dvz = (b_in == 10'b0 ? 1 : 0);
  
endmodule