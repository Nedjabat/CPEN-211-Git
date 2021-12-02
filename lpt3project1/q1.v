module datapath(clk,in,sr,Rn,w,aluop,lt,tsel,bsel,out);
    input clk, w, lt;
    input [7:0] in;
    input [1:0] sr, Rn, aluop;
    input [2:0] bsel, tsel;
    output [7:0] out;
    wire [7:0] next_R0,next_R1,next_R2,next_R3;
    reg [7:0] R0, R1, R2, R3;

    always @(*) begin     //next state case statement
        casex({Rn, w})
            {2'b00,1'b1} : {load0,load1,load2,load3} = 4'b1000;
            {2'b01,1'b1} : {load0,load1,load2,load3} = 4'b0100;
            {2'b10,1'b1} : {load0,load1,load2,load3} = 4'b0010;
            {2'b11,1'b1} : {load0,load1,load2,load3} = 4'b0001;
            default: {load0,load1,load2,load3} = 4'bxxxx;
        endcase
    end
    assign next_R0 = load0 ? rin : R0;

    always @(posedge clk) begin
        R0 = next_R0;
    end

    assign next_R1 = load1 ? rin : R1;

    always @(posedge clk) begin
        R1 = next_R1;
    end

    assign next_R2 = load2 ? rin : R2;

    always @(posedge clk) begin
        R2 = next_R2;
    end

    assign next_R3 = load3 ? rin : R3;

    always @(posedge clk) begin
        R3 = next_R3;
    end

    