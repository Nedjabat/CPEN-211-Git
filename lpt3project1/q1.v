module datapath(clk,in,sr,Rn,w,aluop,lt,tsel,bsel,out);
    input clk, w, lt;
    input [7:0] in;
    input [1:0] sr, Rn, aluop;
    input [2:0] bsel, tsel;
    output [7:0] out;
    wire [7:0] next_R0,next_R1,next_R2,next_R3,rin, Bin,next_lt, ltin;
    reg [7:0] R0, R1, R2, R3, alu_out,tmp;
    reg load0,load1,load2,load3;
    

    always @(*) begin     //next state case statement
        casex({Rn, w})
            {2'b00,1'b1} : {load0,load1,load2,load3} = 4'b1000;
            {2'b01,1'b1} : {load0,load1,load2,load3} = 4'b0100; 
            {2'b10,1'b1} : {load0,load1,load2,load3} = 4'b0010;
            {2'b11,1'b1} : {load0,load1,load2,load3} = 4'b0001;
            default: {load0,load1,load2,load3} = 4'b0000;
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
    assign next_lt = lt ? ltin : tmp;

    always @(posedge clk) begin
        tmp = next_lt;
    end
    always @(*) begin
        casex(aluop)
            2'b00: alu_out = tmp ^ Bin; 
            2'b01: alu_out = tmp & Bin;
            2'b10: alu_out = tmp << 1;
            2'b11: alu_out = Bin;
            default: alu_out =  tmp;
        endcase
    end
    assign out = R0;
    
    mux4to1 #(8) mult1(R1,R2,R3,bsel,Bin);
    //assign Bin = bsel [0] ? (bsel[1] ? (bsel[2] ? 0 : R3):R2 ) : R1;
    mux4to1 #(8) mult2(alu_out,R0,Bin,tsel,ltin);
    //assign ltin = tsel [2] ? (tsel[1] ? (tsel[0] ? 0 :Bin): R0) : alu_out;
    mux3to1 #(8) mult3(in,alu_out,tmp,sr,rin);
endmodule

module mux3to1 (a,b,c,sel,out);
    parameter n=16;
    input [n-1: 0] a, b, c;
    input [1:0] sel;
    output reg [n-1: 0] out;
    always @(*) begin
        casex({sel})
        2'b00 : out = a;
        2'b01 : out = b;
        2'b10 : out = c;
        2'bxx : out = 0;
        endcase
    end
    
endmodule

module mux4to1 (a,b,c,sel,out);
    parameter n=16;
    input [n-1: 0] a, b, c;
    input [2:0] sel;
    output reg [n-1: 0] out;
    always @(*) begin
        casex({sel})
        3'b001 : out = a;
        3'b010 : out = b;
        3'b100 : out = c;
        3'bxxx : out = 0;
        endcase
    end
    
endmodule
    