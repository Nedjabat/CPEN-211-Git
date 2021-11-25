module ALU(Ain,Bin,ALUop,out,z);    
    input [15:0] Ain,Bin;
    input [1:0] ALUop;
    output [15:0] out;
    reg [15:0] out;
    output [2:0]z; 
    reg [2:0] z; 
    wire tempovr;
    wire sub;

    assign sub = ~ALUop[1] & ALUop[0];   
    AddSub #(16) overflow(Ain,Bin,sub, ,tempovr);
    
    always @(*)begin
		z[2]=tempovr;
    end
    
    always @(*) begin
        casex(ALUop)
            2'b00: out = Ain + Bin; 
            2'b01: out = Ain - Bin;
            2'b10: out = Ain & Bin;
            2'b11: out = ~Bin;
            default: out =  Ain;
        endcase
        if (out == 16'b0000000000000000)
        begin
            z[0] = 1'b1;
        end else begin
            z[0] = 1'b0;
        end
        if (out[15] == 1'b1)
        begin
            z[1] = 1'b1;
        end else begin
            z[1] = 1'b0;
        end
    end
endmodule


module AddSub(a,b,sub,s,ovf) ;
    parameter n = 16 ;
    input [n-1:0] a, b ;
    input sub ;           // subtract if sub=1, otherwise add
    output [n-1:0] s ;
    output ovf ;      // 1 if overflow
    wire c1, c2 ;         // carry out of last two bits
    assign ovf = c1 ^ c2 ;  // overflow if signs don't match

  // add non sign bits
    assign {c1,s[n-2:0]} = a[n-2:0] + (b[n-2:0] ^ {n-1{sub}}) + sub;
    
  // add sign bits
    assign {c2, s[n-1]} = a[n-1] + (b[n-1] ^ sub) + c1;
endmodule 

endmodule