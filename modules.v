module subtractor(input [10:0] a, b, output [10:0] w);
  assign w = a - b;  
endmodule

module comparator(input [10:0] a, b, output w);
  assign w = (a >= b) ? 1 : 0;
endmodule

module counter_4_bit(cnt_up, init_counter, clk, rst, init, cnt, cout);
  input cnt_up, init_counter, clk, rst;
  input [3:0] init;
  output reg [3:0] cnt;
  output reg cout;
  
  always @(posedge clk, posedge rst) begin
    if (rst)
    {cout, cnt} <= 5'b0;
    else if (init_counter)
    	cnt <= init;
    else if (cnt_up)
	    {cout, cnt} <= cnt + 1;
  end
  
endmodule

module mux_2_to_1 #(parameter N = 1) (a, b, sel, w);
  input [N-1:0] a, b;
  input sel;
  output reg [N-1:0] w;
  assign w = sel ? b : a;
endmodule

module register #(parameter N = 10) (in, ld, clk, rst, out);
  input [N-1:0] in;
  input ld, clk, rst;
  output reg [N-1:0] out;
  
  always @(posedge clk, posedge rst) begin
    if (rst)
      out <= {N{1'b0}};
    else if (ld)
      out <= in;
  end
  
endmodule


  
  
  
  