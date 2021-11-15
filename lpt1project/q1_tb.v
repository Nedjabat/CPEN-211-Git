module q2_tb;
	reg sim_clk, sim_reset;
	reg [1:0] sim_in;
	wire [2:0] sim_out;

	top_module dut(sim_clk,sim_reset,sim_in,sim_out);

	initial begin
	 sim_clk = 0;
	#5;
  	forever begin 
	 sim_clk = 1 ; #5; //key[0] is not value of clock 
	 sim_clk = 0;  #5; //clock forever goes high and low
      	end
   	end
	initial begin
		sim_reset = 0;
		sim_in = 2'b01;
		#10;
		sim_in = 2'b01;
		#10;
		sim_in = 2'b10;
		#10;
		sim_in = 2'b00;
		#10; 
		sim_in = 2'b01;
		#10;
		sim_in = 2'b00;
		#10;
		sim_in = 2'b00;
		#10; 
		sim_in = 2'b11;
		#10;
		$stop;
	end
endmodule