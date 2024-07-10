`define Idle 3'b000
`define Init 3'b001
`define Init2 3'b111
`define Count 3'b010
`define Load 3'b011
`define End 3'b100
`define Overflow 3'b101
`define DivideZero 3'b110

module controller(start, co, dvz, ovf, clk, rst, ld_a, ld_b, ld_acc, ld_q, init_counter, sel_q, sel_acc, busy, valid, count_up);
  input start, co, dvz, ovf, clk, rst;
  output reg ld_a, ld_b, ld_acc, ld_q, init_counter, sel_q, sel_acc, busy, valid, count_up;
  
  reg [2:0] ps, ns;
  
  always @(posedge clk) begin
    if (rst)
      ps <= `Idle;
    else
      ps <= ns;
  end
  
  always @(ps, start, dvz, co, ovf) begin
    case (ps)
      `Idle: ns = start ? `Init : `Idle;
	  `Init: ns = `Init2;
      `Init2: ns = dvz ? `DivideZero : `Count;
      `Count: ns = co ? `End : `Load;
      `Load: ns = ovf ? `Overflow : `Count;
      `End: ns = `Idle;
      `Overflow: ns = `Idle;
      `DivideZero: ns = `Idle;
      default: ns = `Idle;
    endcase
  end
  
  always @(ps) begin
    {ld_a, ld_b, ld_acc, ld_q, init_counter, sel_q, sel_acc, busy, count_up, valid} = 10'b0;
    case (ps)
      `Idle: ;
      `Init: {ld_a, ld_b, init_counter, busy} = 4'b1111;
	  `Init2: {ld_acc, ld_q, sel_q, sel_acc, busy} = 5'b11111;
      `Count: busy = 1'b1;
      `Load: {count_up, ld_acc, ld_q, busy} = 4'b1111;
      `End: valid = 1'b1;
      `Overflow: ;
      `DivideZero: ;
      default: ;
    endcase
  end
  
endmodule