module ALU(Ain,Bin,ALUop,out,z);    
    input [15:0] Ain,Bin;
    input [1:0] ALUop;
    output [15:0] out;
    reg [15:0] out;
    output z; 
    reg z; 

    always @(*) begin
        casex(ALUop)
            2'b00: out = Ain + Bin;
            2'b01: out = Ain - Bin;
            2'b10: out = Ain & Bin;
            2'b11: out = ~Bin;
            default: out =  Ain;
        endcase
        if (out == 16'b0000000000000000);
        begin
            z = 1;
        end
    end


endmodule