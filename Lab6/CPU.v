module cpu(clk,reset,s,load,in,out,N,V,Z,w);
    input clk, reset, s, load;
    input [15:0] in;
    output [15:0] out;
    output N, V, Z, w;
    reg [15:0]  in_out;
    wire [15:0] in, next_out_in;
    wire load;

    assign next_out_in = load ? in : in_out;  

    always @(posedge clk)
    begin
	
	    in_out = next_out_in; 
	
    end

    decoder dec(in,nsel,ALUop,sximm5,sximm8,shift,readnum,writenum,opcode,op);

    datapath data(clk,N,V,Z,datapath_in,write,vsel,loada,loadb,asel,bsel,loadc,loads,readnum,writenum,shift,ALUop,out,sximm5,sximm8);
endmodule
  