module Shifter(in,shift,sout);
    input [15:0] in;
    input [1:0] shift;
    output [15:0] sout;
    reg [15:0] sout;

    always @(*) begin
        casex(shift)
            00:begin sout = in;end
            01:begin sout = in<<1; sout[0] = 0;end
            10:begin sout = in>>1; sout[15] = 0;end
            11:begin sout = in>>1; sout[15] = in[15];end
            default: sout = in;
        endcase
    end


endmodule
