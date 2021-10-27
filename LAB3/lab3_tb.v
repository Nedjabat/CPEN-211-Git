module lab3_top_tb;


	reg [9:0] sim_SW; //Declare local variables for testing
	reg [3:0] sim_KEY;
	wire [6:0] sim_HEX0, sim_HEX1, sim_HEX2, sim_HEX3, sim_HEX4, sim_HEX5;
	reg err;
	

    `define SX 4
    `define S1 4'b0000
    `define S2 4'b0001
    `define S3 4'b0010
    `define S4 4'b0011
    `define S5 4'b0100
    `define S6 4'b0101
    `define S7 4'b0111
    `define S8 4'b1000
    `define S9 4'b1001
    `define S10 4'b1010
    `define S11 4'b1011
    `define S12 4'b1100
    `define S13 4'b1101
    `define OPEN 4'b1111
    `define CLOSE 4'b1110

	lab3_top dut(sim_SW, sim_KEY, sim_HEX0, sim_HEX1, sim_HEX2, sim_HEX3, sim_HEX4, sim_HEX5); //instiate top

task my_checker;

	input [3:0] expected_state; //inputs to check code
	input [7:0] expected_output;

begin
	if (lab3_top_tb.dut.state !== expected_state ) begin
			$display("ERROR ** state is %b, expected %b", lab3_top_tb.dut.state, expected_state); //checks if state is equal to what we expect it to be 
		err = 1'b1;
	end
	 
	if (sim_HEX0 !== expected_output ) begin
			$display("ERROR ** output is %b, expected %b", sim_HEX0, expected_output);//checks if HEX[0] is equal to what we expect it to be 
		err = 1'b1;
	end
	end
endtask

initial begin
	 sim_KEY[0] = 1;
	#5;
  forever begin 
	 sim_KEY[0]=0 ; #5; //key[0] is not value of clock 
	 sim_KEY[0]=1;  #5; //clock forever goes high and low
      end
   end

initial begin
	
	
	
	sim_KEY[3] = 1'b1;
	err= 1'b0;
	$display ("checking S1->S2"); //test recieving the correct input to go to state 2
	{sim_SW[0],sim_SW[1],sim_SW[2],sim_SW[3]} = 4'b0101; #10;
	my_checker (`S2, 7'b0010010);

	$display ("checking S2->S3"); //test recieving the correct input to go to state 3
	{sim_SW[0],sim_SW[1],sim_SW[2],sim_SW[3]} = 4'b0000; #10;
	my_checker (`S3, 7'b1000000);

	$display ("checking S3->S4"); //test recieving the correct input to go to state 4
	{sim_SW[0],sim_SW[1],sim_SW[2],sim_SW[3]} = 4'b0001; #10;
	my_checker (`S4, 7'b1111001);

	sim_KEY[3]=1'b0;{sim_SW[0],sim_SW[1],sim_SW[2],sim_SW[3]} = 4'b0000; #10;//test reset
	my_checker (`S1, 7'b1111111);#10;

if (~err) $display("PASSED");
else $display("FAILED");
$stop;
end
endmodule



	