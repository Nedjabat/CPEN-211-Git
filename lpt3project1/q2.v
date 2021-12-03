module bitwise(clk,reset,s,op,in,out,done);
    input clk, reset, s;
    input [7:0] in;
    input [3:0] op;
    output [7:0] out;
    output done;
    reg [1:0] sr, Rn, aluop;
    reg w, lt, done;
    wire [2:0] bsel, tsel;
    datapath DP(clk,in,sr,Rn,w,aluop,lt,tsel,bsel,out);
    always @(*) begin 
        casex({op,s})
            {4'b0000,1'b1} : {Rn,w,sr, done} = {2'b00, 1'b1, 2'b00,1'b0};
            {4'b0001,1'b1} : {Rn,w,sr, done} = {2'b01, 1'b1, 2'b00,1'b0};
            {4'b0010,1'b1} : {Rn,w,sr, done} = {2'b10, 1'b1, 2'b00,1'b0};
            {4'b0011,1'b1} : {Rn,w,sr, done} = {2'b11, 1'b1, 2'b00,1'b0};
            default : {Rn,w,sr, done} = {2'bxx, 1'bx, 2'bxx,1'b1};
        endcase
    end

endmodule