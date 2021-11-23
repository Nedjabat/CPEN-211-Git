module datapath_tb;

    reg [15:0] datapath_in; //declare inputs/outputs 
    wire [15:0] datapath_out;
    wire Z_out;
    reg vsel, write, clk, loada, loadb, loadc, loads, asel, bsel;
    reg [2:0] writenum, readnum;
    reg [1:0] shift, ALUop;

datapath DUT(clk,Z_out,datapath_in,write,vsel,loada,loadb,asel,bsel,loadc,loads,readnum,writenum,shift,ALUop,datapath_out); //instantiate datapath

reg err=0; 

task my_checker;
    input [15:0] expected_datapath_out;
    begin
       if(datapath_tb.DUT.datapath_out !== expected_datapath_out)
       begin
          $display ("ERROR datapath_out is %b, expected %b", datapath_tb.DUT.datapath_out, expected_datapath_out);
          err = 1; 
       end
    end
endtask

initial begin
    clk = 0; #5;
    forever begin
        clk = 1; #5;
        clk = 0; #5;
    end
end
initial begin

    datapath_in = 16'b0000000000000001; //datapath in = 1
    vsel = 1; 

    writenum = 3'b000; //store 1 in R0 
    write = 1;
    #10;
 
    datapath_in = 16'b0000000000000010; //datapathin = 2
    vsel = 1;

    writenum = 3'b001; //store 2 in R1
    write = 1;
    #10;

    readnum = 3'b001; //read from R1 
    loada = 1; 
    #10; 
    loada = 0;

    readnum = 3'b000; //read from R0 and shift left by 1 (1*2=2)
    loadb = 1;
    #10;
    loadb = 0;
    shift = 2'b01;


    asel = 0; // send into ALU and add together (2+2)= 4
    bsel = 0;
    ALUop = 2'b00;

    loadc = 1; //send to datapath_out
    loads = 1;
    #10;

    loadc = 0;
    vsel =0;
    write = 1;
    writenum = 3'b010; //store result in R2
    #10;


    my_checker(16'b0000000000000100); //check value
#10;
$stop;
end
endmodule

