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
    //assign out = sel[1] ? (sel[0] ? 0 : c) : (sel[0] ? b : a);
endmodule