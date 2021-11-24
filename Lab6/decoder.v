module decoder(in,nsel,ALUop,sximm5,sximm8,shift,readnum,writenum,opcode,op);
    input [15:0] in;
    input [1:0] nsel;
    output [15:0] sximm5, sximm8;
    output [2:0] readnum,writenum,opcode;
    output [1:0] ALUop,shift,op;
    

    assign opcode = in[15:13];  
    assign op = in[12:11];
    assign ALUop = in[12:11];
    assign sximm5 = {11'b0,in[4:0]};
    assign sximm8 = {8'b0,in[7:0]};
    assign shift = in[4:3];
    mux3to1 #(3) reader(in[2:0],in[7:5],in[10:8],nsel,readnum);
    mux3to1 #(3) writer(in[2:0],in[7:5],in[10:8],nsel,writenum);
endmodule