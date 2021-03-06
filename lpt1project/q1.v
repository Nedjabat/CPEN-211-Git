module top_module(clk,reset,in,out);
    input clk, reset;
    input [1:0] in;
    output [2:0] out;
    reg [2:0] out;


    `define SX 3 //define states 
    `define SA 3'b000
    `define SB 3'b001
    `define SC 3'b010
    `define SD 3'b011
    `define SE 3'b100
    
    wire [2:0] state, next_state_reset;  // declare states for flip flop and reset logic
    reg [2:0] next_state;

    vDFF #(`SX) STATE(clk,next_state_reset,state); // D flipflop

  // reset logic
    assign next_state_reset = reset ? `SA: next_state;

  // next state case statement
    always @* 
    begin
        casex ({state,in})
          {`SA, 2'b01}: {next_state,out} = {`SB,3'b000};
          {`SA, 2'b10}: {next_state,out} = {`SD,3'b000};
          {`SA, 2'bxx}: {next_state,out} = {`SA,3'b000};
          {`SB, 2'bxx}: {next_state,out} = {`SA,3'b001};
          {`SC, 2'b11}: {next_state,out} = {`SD,3'b010};
          {`SC, 2'b10}: {next_state,out} = {`SB,3'b010};
          {`SC, 2'bxx}: {next_state,out} = {`SC,3'b010};
          {`SD, 2'bxx}: {next_state,out} = {`SE,3'b100};
          {`SE, 2'b01}: {next_state,out} = {`SC,3'b000};
          {`SE, 2'bxx}: {next_state,out} = {`SE,3'b000};
	default : {next_state,out} = {`SA,3'b000};
      endcase
    end
endmodule

module vDFF (clk,in,out); // module defination of flipflop
	parameter n=1;
	input clk;
	input [n-1:0] in;
	output [n-1:0] out;
	reg [n-1:0] out;
	
always @(posedge clk) //depends on rising edge of clock
	out=in;
endmodule