module shifter_tb;
    wire [15:0] sout;
	reg [15:0] in;
	reg [1:0] shift;
	reg err = 0; 
	shifter DUT(in,shift,sout);
	
	 task test;
		input[15:0] expected_data_out;
		begin
    			if(shifter_tb.DUT.sout !== expected_data_out)
			begin
				$display("ERROR output is %b, expected %b",shifter_tb.DUT.sout, expected_data_out);
				err=1 ;
    			end
  		end
  	endtask
	initial 
	begin
		in = 16'b1100000110000011;
		shift = 2'b00; #5;
		$display("checking for if in is shifted left with LSB = 0 and is stored in shift out");
		test(16'b1100000110000011);// Testing no shift part of shifter expecting same as input

		in = 16'b1100000110000011;
		shift = 2'b01; #5;
		$display("checking for if in is shifted left with LSB = 0 and is stored in shift out");
		test(16'b1000001100000110);// Testing shift left with LSB = 0 part of shifter expecting 1000001100000110
		
		in = 16'b1100000110000011;
		shift = 2'b10; #5;
		$display("checking for if in is shifted right with MSB = 0 and is stored in shift out");
		test(16'b0110000011000001);// Testing shift right with MSB = 0 part of shifter expecting 0110000011000001

		in = 16'b1100000110000011;
		shift = 2'b11; #5;
		$display("checking for if in is shifted right with MSB = in[15] and is stored in shift out");
		test(16'b1110000011000001);// Testing shift right with MSB = in[15] part of shifter expecting 1110000011000001



	end 
endmodule