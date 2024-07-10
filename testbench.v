module divider_TB();
    reg [9:0] a_in, b_in;
    reg start, sclr, clk;
    wire [9:0] q_out;
    wire busy, valid;
    wire dvz, ovf;
    divider CUT(a_in, b_in, start, sclr, clk, q_out, dvz, ovf, busy, valid);

    always #5 clk = ~clk;
    initial begin
		clk = 0;
		start = 0;
		sclr = 0;
		a_in = 0;
		b_in = 0;
        #50 sclr = 1;
        #50 sclr = 0;
  		#50 a_in = 10'b0011000000; //12
      	#50 b_in = 10'b0000000100; //0.25
		#50 start = 1;
		#50 start = 0;
		#500 $stop;
    end
endmodule
        
module divider_TB2();
    reg [9:0] a_in, b_in;
    reg start, sclr, clk;
    wire [9:0] q_out;
    wire busy, valid;
    wire dvz, ovf;
    divider CUT2(a_in, b_in, start, sclr, clk, q_out, dvz, ovf, busy, valid);

    always #5 clk = ~clk;
    initial begin
		clk = 0;
		start = 0;
		sclr = 0;
		a_in = 0;
		b_in = 0;
        #50 sclr = 1;
        #50 sclr = 0;
  		#50 a_in = 10'b0011000000; //12
      	#50 b_in = 10'b0000000000; //0
		#50 start = 1;
		#50 start = 0;
		#500 $stop;
    end
endmodule
 
module divider_TB3();
    reg [9:0] a_in, b_in;
    reg start, sclr, clk;
    wire [9:0] q_out;
    wire busy, valid;
    wire dvz, ovf;
    divider CUT3(a_in, b_in, start, sclr, clk, q_out, dvz, ovf, busy, valid);

    always #5 clk = ~clk;
    initial begin
		clk = 0;
		start = 0;
		sclr = 0;
		a_in = 0;
		b_in = 0;
        #50 sclr = 1;
        #50 sclr = 0;
  		#50 a_in = 10'b0000111000; 
      	#50 b_in = 10'b0000000100; 
		#50 start = 1;
		#50 start = 0;
		#500 $stop;
    end
endmodule