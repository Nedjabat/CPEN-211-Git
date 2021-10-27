module SEG(in,state,reset,out0,out1,out2,out3,out4,out5);
     
     //Declare inputs,outputs and internal variables.
     input [3:0] in; 
     input [3:0] state;
     input reset;
     output [6:0] out0,out1,out2,out3,out4,out5;
     reg [6:0] out0,out1,out2,out3,out4,out5;

	`define x0 4'b0000  //define numbers in binary
	`define x1 4'b0001
	`define x2 4'b0010
	`define x3 4'b0011
	`define x4 4'b0100
	`define x5 4'b0101
	`define x6 4'b0110
	`define x7 4'b0111
	`define x8 4'b1000
	`define x9 4'b1001
	`define x10 4'b1010
	`define x11 4'b1011
	`define x12 4'b1100
        `define OPEN 4'b1111
        `define CLOSED 4'b1110
        `define ERROR 4'b1101

    always @(in) //depends on change on what to display
    begin
        casex ({in,state,reset}) //display numbers onto 7 segment displays
	    {4'bxxxx,4'bxxxx,1'b1}: {out0,out1,out2,out3,out4,out5} = {7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111}; //reset displays off
            {`x0,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b1000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x1,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b1111001,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x2,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0100100,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x3,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0110000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x4,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0011001,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x5,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0010010,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x6,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0000010,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x7,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b1111000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x8,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0000000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
            {`x9,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0010000,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111};
	    {`x10,4'bxxxx,1'b0}:{out0,out1,out2,out3,out4,out5}={7'b0000110,7'b0101111,7'b0101111,7'b1000000,7'b0101111,7'b1111111};
	    {`x11,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0000110,7'b0101111,7'b0101111,7'b1000000,7'b0101111,7'b1111111};
 	    {`x12,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0000110,7'b0101111,7'b0101111,7'b1000000,7'b0101111,7'b1111111};
	    {`ERROR,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0000110,7'b0101111,7'b0101111,7'b1000000,7'b0101111,7'b1111111};
	    {`OPEN,4'b0111,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b1000000,7'b0001100,7'b0000110,7'b0101010,7'b1111111,7'b1111111};
	    {`CLOSED,4'b1101,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b1000110,7'b1000111,7'b1000000,7'b0010010,7'b0000110,7'b0100001};
 	    {`OPEN,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0000110,7'b0101111,7'b0101111,7'b1000000,7'b0101111,7'b1111111};
 	    {`CLOSED,4'bxxxx,1'b0}: {out0,out1,out2,out3,out4,out5}={7'b0000110,7'b0101111,7'b0101111,7'b1000000,7'b0101111,7'b1111111};
 	    
           
            
            
            default : {out0,out1,out2,out3,out4,out5} = {7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111,7'b1111111}; //default displays off
        endcase
    end

endmodule
