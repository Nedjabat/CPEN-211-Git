module cpu(clk,reset,s,load,in,out,N,V,Z,w);
    input clk, reset, s, load;
    input [15:0] in;
    output [15:0] out;
    output N, V, Z, w;
    reg [15:0]  in_out;
    wire [15:0] in, next_out_in,sximm5,sximm8;
    wire [2:0] opcode,readnum,writenum;
    wire [1:0] op, vsel, nsel, ALUop, shift;
    wire load, loads, reset, w, s, clk, loada, loadb, loadc, asel, bsel, write;

    assign next_out_in = load ? in : in_out;  

    always @(posedge clk)
    begin
	
	    in_out = next_out_in; 
	
    end

    decoder dec(in_out,nsel,ALUop,sximm5,sximm8,shift,readnum,writenum,opcode,op);
    FSM machine(reset,w,loads,s,op, opcode,clk,loada,loadb,loadc,asel,bsel,vsel,write,nsel);
    datapath DP(clk,N,V,Z,write,vsel,loada,loadb,asel,bsel,loadc,loads,readnum,writenum,shift,ALUop,out,sximm5,sximm8);
    
endmodule
  