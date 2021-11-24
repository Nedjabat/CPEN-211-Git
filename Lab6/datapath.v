module datapath(clk,N,V,Z,write,vsel,loada,loadb,asel,bsel,loadc,loads,readnum,writenum,shift,ALUop,datapath_out,sximm5,sximm8);
  

    input [15:0] sximm5,sximm8;
    input [2:0] writenum,readnum;
    input[1:0] shift, ALUop,vsel;
    input write, clk, loada, loadb, loadc, loads, asel, bsel;
    output [15:0] datapath_out;
    output N,V,Z;

    wire [7:0] PC;
    wire [15:0]data_in, data_out, Ain, Bin, out,next_out_a, next_out_b, next_datapath_out, sout, mdata, sximm5, sximm8;
    wire [2:0] writenum, readnum, status, next_out_z;
    wire [1:0] shift, ALUop, vsel;
    wire loada, loadb, asel, bsel, loads, loadc, write, clk;
    reg [15:0] in, a_out, datapath_out;
    reg [2:0]  Z_out;
    reg N,V,Z;

    assign PC = 0;
    assign mdata = 0;
    mux4to1 #(16) intl(mdata,sximm8,{8'b0,PC},datapath_out,vsel,data_in);

    regfile REGFILE(data_in,writenum,write,readnum,clk,data_out);

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
    assign Bin = bsel ? sximm5 : sout;//multiplexer 7

    ALU DUT2(Ain, Bin, ALUop, out, status); //ALU instance 2 

    assign next_datapath_out = loadc ?  out : datapath_out; // pipeline register 5
    assign next_out_z = loads ? status : Z_out; //status register 10

    always@(posedge clk)
        begin
	        datapath_out = next_datapath_out;//Register 5
        end
    always @(posedge clk)
        begin
            Z_out = next_out_z;//Register 10
        end	
    always @(posedge clk)
        begin
            N = Z_out[1];//Register 10
        end	
    always @(posedge clk)
        begin
            V = Z_out[2];//Register 10
        end
    always @(posedge clk)
        begin
            Z = Z_out[0];//Register 10
        end
endmodule
