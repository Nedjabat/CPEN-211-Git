module FSM(reset,w,loads, s,op, opcode,clk,loada,loadb,loadc,asel,bsel,vsel,write,nsel);
input reset, s,clk;
input [1:0] op;
input [2:0] opcode;
output reg w, loada,loadb,loadc,asel,bsel,write,loads;
output reg [1:0] nsel;
output reg [1:0] vsel;

wire [3:0]  next_state_reset; 
reg [3:0] state;
reg [3:0] next_state;

`define Wait 4'b0000
`define Decode 4'b0001
`define GetA 4'b0010
`define GetB 4'b0011
`define Add 4'b0100 
`define WriteReg 4'b0101 
`define WriteImm 4'b0110
`define C 4'b0111
`define MVN 4'b1000
`define ADD 4'b1001
`define CMP 4'b1010
`define AND 4'b1011

//vDFF STATE(clk,next_state_reset,state); //flipflop for fsm
always @(posedge clk) begin
	state = next_state_reset;
end

assign next_state_reset = reset ? `Wait : next_state; //reset logic

always @* begin     //next state case statement
    casex({state,s,opcode,op})
        {`Wait,6'b1_xxx_xx}     : next_state = `Decode;
        {`Wait,6'bx_xxx_xx}     : next_state = `Wait;
        {`Decode,6'bx_110_10}   : next_state = `WriteImm;
        {`WriteImm,6'bx_xxx_xx} : next_state = `Wait;
        {`Decode,6'bx_xxx_xx}   : next_state = `GetB;
        {`GetB,6'bx_110_00}     : next_state = `C;
        {`C,6'bx_xxx_x}         : next_state = `WriteReg;
        {`GetB,6'bx_101_11}     : next_state = `MVN;
        {`MVN,6'bx_xxx_xx}      : next_state = `WriteReg;
        {`GetB,6'bx_101_xx}     : next_state = `GetA;
        {`GetA,6'bx_xxx_00}     : next_state = `ADD;
        {`GetA,6'bx_xxx_01}     : next_state = `CMP;
        {`GetA,6'bx_xxx_10}     : next_state = `AND;
        {`ADD, 6'bx_xxx_xx}     : next_state = `C;
        {`AND, 6'bx_xxx_xx}     : next_state = `C;
        {`CMP, 6'bx_xxx_xx}     : next_state = `Wait;
        default: next_state = 4'bxxxx;
    endcase
end

always @* begin       //output case statement
    casex(state)
        `Wait       : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b1_0_0_0_00_0_0_00_0_0;
        `Decode     : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_0_00_0_0_00_0_0;
        `WriteImm   : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_1_01_0_0_10_0_1;
        `GetA       : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_1_0_0_00_0_0_10_0_0;
        `GetB       : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_1_0_00_0_0_00_0_0;
        `ADD        : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_1_00_0_0_00_0_0;
        `WriteReg   : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_0_11_0_0_01_0_1;
        `C          : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_1_00_0_0_00_0_0;
        `MVN        : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_0_00_0_0_00_0_0; 
        `CMP        : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_0_00_0_0_00_1_0;
        `AND        : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'b0_0_0_0_00_0_0_00_0_0;
        default     : {w,loada,loadb,loadc,vsel,asel,bsel,nsel,loads,write} = 15'bxxxxxxxxxxxxxxx;
    endcase 
end
endmodule


/*module vDFF (clk,in,out); // module defination of flipflop
	input clk;
	input [2:0] in;
	output [2]:0] out;
	reg [2:0] out;
	
always @(posedge clk)begin //depends on rising edge of clock
	out=in;
end
endmodule*/
