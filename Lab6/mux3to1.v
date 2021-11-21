module mux3to1 (a,b,c,sel,out);
    parameter n=16;
    input [n-1: 0] a, b, c;
    input [1:0] sel;
    output [n-1: 0] out;
    assign out = sel[1] ? (sel[0] ? 0 : c) : (sel[0] ? b : a);
endmodule