module MealyDec(state,in,out);
    input [1:0] state;
    input in;
    output [2:0] out;
    reg [2:0] out;
    `define SA 2'b00
    `define SB 2'b01
    `define SC 2'b10
    `define SD 2'b11


    always @(state,in)
    begin
        casex ({state,in})
            {`SA,1'b1}: out = 3'b101;
            {`SA,1'b0}: out = 3'b111;
            {`SB,1'b1}: out = 3'b011;
            {`SB,1'b0}: out = 3'b001;
            {`SC,1'b1}: out = 3'b100;
            {`SC,1'b0}: out = 3'b000;
            {`SD,1'bx}: out = 3'b110;
            default: out = 3'b010;
        endcase
    end
endmodule