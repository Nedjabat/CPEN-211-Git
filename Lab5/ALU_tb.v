module ALU_tb;
    wire [15:0] out;
	reg [15:0] Ain, Bin; //Declare inputs and outputs
	reg [1:0] ALUop;
	wire Z;
	reg err = 0;
	ALU DUT(Ain,Bin,ALUop,out,Z);
	 task test;
    		input[15:0] expected_data_out;
		begin
			if(ALU_tb.out !== expected_data_out)
				begin
				$display("ERROR output is %b, expected %b",ALU_tb.DUT.out, expected_data_out);
				err=1 ;
	    			end
	  end
  endtask
	initial begin
		Ain = 16'b0000000000000011; 
		Bin = 16'b0000000000000011;
		$display("checking for if Ain + Bin is stored in out"); 
		ALUop = 2'b00; #5;
		test(16'b0000000000000110); // Testing addition part of ALU expecting 0000000000011110
		$display("checking for if Ain - Bin is stored in out"); 
		ALUop = 2'b01; #5;
		test(16'b0000000000000000); // Testing subtraction part of ALU expecting 0000000000000000 
		$display("checking for if Ain & Bin is stored in out"); 
		ALUop = 2'b10; #5;
		test(16'b0000000000000011); // Testing AND part of ALU expecting 0000000000001111 
		$display("checking for if ~Bin is stored in out"); 
		ALUop = 2'b11; #5;
		test(16'b1111111111111100); // Testing NOT Bin part of ALU expecting 1111111111110000 
			
	end 
endmodule