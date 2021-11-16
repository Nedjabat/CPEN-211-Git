module datapath(datapath_in,vsel,writenum,write,readnum,clk,loada,loadb,shift,ALUop,loadc,loads,Z_out,datapath_out,asel,bsel);
    input [15:0] datapath_in;
    input [2:0] writenum,readnum;
    input[1:0] shift, ALUop;
    input write, clk, loada, loadb, loadc, loads, asel, bsel, vsel;
    output [15:0] datapath_out;
    output Z_out;


    wire [15:0]data_in, data_out, Ain, Bin, out, datapath_in,next_out_a, next_out_b, next_out_datapath, sout;
    wire [2:0] writenum, readnum;
    wire [1:0] shift, ALUop;
    wire Z, loada, loadb, asel, bsel, vsel, loads, loadc, write, next_out_z, clk;

    reg [15:0] in, a_out, datapath_out;
    reg Z_out;

    assign data_in = vsel ? datapath_in : datapath_out;//writeback register 9

    //regfile instance 1

    assign next_out_a = loada ? data_out : a_out;  //pipleine register 3
    assign next_out_b = loadb ? data_out : in;  //pipleine register 4

    always @(posedge clk)
        begin
	
	        a_out = next_out_a; //Register 3 
	
            end
    always @(posedge clk)
        begin

	        in = next_out_b;//Register 4
	
        end

    shifter DUT1(in, shift, sout); //shifter instance 8

    assign Ain = asel ? 16'b0 : a_out;//multiplexer 6
    assign Bin = bsel ? {11'b0,datapath_in[4:0]} : sout;//multiplexer 7

    ALU DUT2(Ain, Bin, ALUop, out, Z); //ALU instance 2 

    assign next_datapath_out = loadc ? out : datapath_out; // pipeline register 5
    assign next_out_z = loads ? Z : Z_out; //status register 10

    always@(posedge clk)
        begin
	        datapath_out = next_out_datapath;//Register 5
        end
    always @(posedge clk)
        begin
            Z_out = next_out_z;//Register 10
        end	
endmodule