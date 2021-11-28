module mux4to1 (a,b,c,d,sel,out);
    parameter n=16;
    input [n-1: 0] a, b, c, d;
    input [1:0] sel;
    output [n-1: 0] out;
    assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);
endmodule