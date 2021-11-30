module cpu(clk,reset,s,load,in,out,N,V,Z,w);
    input clk, reset, s, load;
    input [15:0] in;
    output [15:0] out;
    output N, V, Z, w;
    reg [15:0]  in_out;
    reg [8:0] pc_out, data_out;
    wire [15:0] in, next_out_in,sximm5,sximm8;
    wire [8:0] next_pc, incremental, next_out_pc, next_out_data; 
    wire [2:0] opcode,readnum,writenum;
    wire [1:0] op, vsel, nsel, ALUop, shift;
    wire load, loads, reset, w, s, clk, loada, loadb, loadc, asel, bsel, write, load_pc, reset_pc, addr_sel, load_addr;

    assign next_out_in = load ? in : in_out;  

    always @(posedge clk)
    begin
	
	    in_out = next_out_in; 
	
    end

    decoder dec(in_out,nsel,ALUop,sximm5,sximm8,shift,readnum,writenum,opcode,op);
    FSM machine(reset,w,loads,s,op, opcode,clk,loada,loadb,loadc,asel,bsel,vsel,write,nsel,load_addr);
    datapath DP(clk,N,V,Z,write,vsel,loada,loadb,asel,bsel,loadc,loads,readnum,writenum,shift,ALUop,out,sximm5,sximm8,in);
    
    assign next_pc = reset_pc ?  incremental : 9'b0;

    assign next_out_pc = load_pc ? next_pc : pc_out;

    assign incremental = next_pc  + 9'b000000001;


    assign mem_addr = addr_sel ? data_out : next_pc;


    always @(posedge clk)
    begin
	
	    pc_out = next_out_pc; 
	
    end
    
    assign next_out_data = load_addr ? out[8:0] : data_out;
    
    always @(posedge clk)
    begin
	
	    data_out = next_out_data; 
	
    end
endmodule
  