module regfile_tb;
  reg clk, write;
  reg[15:0] data_in;
  reg[2:0] writenum,readnum;
  wire [15:0]data_out;
 
 regfile DUT(data_in,writenum,write,readnum,clk,data_out);

  reg err;

  task test;
    input[15:0] expected_data_out;
  begin
    if(regfile_tb.DUT.data_out !== expected_data_out)begin
	$display("ERROR** output is %b, expected %b",regfile_tb.DUT.data_out, expected_data_out);
	 err=1 ;
    end
  end
  endtask
   
  initial begin
	
    clk=0; #5;
      forever begin
        clk=1; #5;
        clk=0; #5;
        
      end
  end
  
  initial begin
   err=0;
  #5;
  $display("checking for 1 in R0"); //check to see if binary for 0 is succesfully stored and read from R0
  writenum= 3'b000;
  write=1;
  data_in=16'b0000000000000000;
  readnum= 3'b000;
  #10;
  test(16'b0000000000000000);

 $display("checking for 1 in R1"); //check to see if binary for 1 is succesfully stored and read from R1
  writenum= 3'b001;
  write=1;
  data_in=16'b0000000000000001;
  readnum= 3'b001;
  #10;
  test(16'b0000000000000001);

  $display("checking for 2 in R2"); //check to see if binary for 2 is succesfully stored and read from R2
  writenum= 3'b010;
  write=1;
  data_in=16'b0000000000000010;
  readnum=3'b010;
  #10;
  test(16'b0000000000000010);
 
  $display("checking for 3 in R3"); //checks to see if binary for 3 is succesfully stored and read from R3
  writenum= 3'b011;
  write=1;
  data_in=16'b0000000000000011;
  readnum=3'b011;
  #10;
  test(16'b0000000000000011);
 
  $display("checking for 4 in R4"); //checks to see if binary for 4 is succesfully stored and read from R4
  writenum=3'b100;
  write=1;
  data_in=16'b0000000000000100;
  readnum=3'b100;
  #10;
  test(16'b0000000000000100);

  $display("checking for 5 in R5"); //checks to see if binary for 5 is succesfully stored and read from R5
  writenum=3'b101;
  write=1;
  data_in=16'b0000000000000101;
  readnum=3'b101;
  #10;
  test(16'b0000000000000101);
  
  $display("checking for 6 in R6"); //checks to see if binary for 6 is succesfully stored and read from R6
  writenum=3'b110;
  write=1;
  data_in=16'b0000000000000110;
  readnum=3'b110;
  #10;
  test(16'b0000000000000110);

  $display("checking for 7 in R7"); //checks to see if binary for 7 is succesfully stored and read from R7
  writenum=3'b111;
  write=1;
  data_in=16'b0000000000000111;
  readnum=3'b111;
  #10;
  test(16'b0000000000000111);
 $stop;
  end

endmodule
