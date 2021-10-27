module FSM(in, clk, reset, out, state);
    input [3:0] in;
    input clk; //Declare inout variables.
    output [3:0] out;
    output [3:0] state;
    reg [3:0] out;
    input reset;
    
    `define SX 4 //define states 
    `define S1 4'b0000
    `define S2 4'b0001
    `define S3 4'b0010
    `define S4 4'b0011
    `define S5 4'b0100
    `define S6 4'b0101
    `define S7 4'b0111
    `define S8 4'b1000
    `define S9 4'b1001
    `define S10 4'b1010
    `define S11 4'b1011
    `define S12 4'b1100
    `define S13 4'b1101
    `define OPEN 4'b1111
    `define CLOSE 4'b1110

    wire [3:0] state, next_state_reset;  // declare states for flip flop and reset logic
    reg [3:0] next_state;

    vDFF #(`SX) STATE(clk,next_state_reset,state); // D flipflop

  // reset logic
    assign next_state_reset = reset ? 4'b0000 : next_state;

  // next state case statement
    always @* begin
        casex ({state,in})
            {`S1, 4'b0101}: next_state = `S2;
            {`S1, 4'bxxxx}: next_state = `S8;
            {`S2, 4'b0000}: next_state = `S3;
            {`S2, 4'bxxxx}: next_state = `S9;
            {`S3, 4'b0001}: next_state = `S4;
            {`S3, 4'bxxxx}: next_state = `S10;
            {`S4, 4'b0101}: next_state = `S5;
            {`S4, 4'bxxxx}: next_state = `S11;
            {`S5, 4'b0001}: next_state = `S6;
            {`S5, 4'bxxxx}: next_state = `S12;
            {`S6, 4'b0000}: next_state = `S7;
            {`S6, 4'bxxxx}: next_state = `S13;
            {`S7, 4'bxxxx}: next_state = `S7;
            {`S8, 4'bxxxx}: next_state = `S9;
            {`S9, 4'bxxxx}: next_state = `S10;
            {`S10, 4'bxxxx}: next_state = `S11;
            {`S11, 4'bxxxx}: next_state = `S12;
            {`S12, 4'bxxxx}: next_state = `S13;
            {`S13, 4'bxxxx}: next_state = `S13;
		default : next_state= `S13;
    endcase
end

    always @* begin // output case statement
       casex (state)
	`S1: out = in;
	`S2: out = in;
	`S3: out = in;
	`S4: out = in;
	`S4: out = in;
	`S5: out = in;
	`S6: out = in;
	`S7: out = `OPEN;
	`S8: out = in;
	`S9: out = in;
	`S10: out = in;
	`S11: out = in;
	`S12: out = in;
	`S13: out = `CLOSE;
	default: out = `CLOSE;
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
