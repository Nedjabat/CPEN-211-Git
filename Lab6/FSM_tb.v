module fsm_tb;
`define Wait 4'b0000
`define Decode 4'b0001
`define GetA 4'b0010
`define GetB 4'b0011
`define Add 4'b0100 
`define WriteReg 4'b0101 
`define WriteImm 4'b0110
`define C 4'b0111
`define MVN 4'b1000
`define ADD 4'b1001
`define CMP 4'b1010
`define AND 4'b1011
reg clk,s,reset;
reg [3:0] state;
reg [1:0] op;
reg [2:0] opcode;
wire [1:0] nsel, vsel;
FSM DUT(reset,w,loads, s,op, opcode,clk,loada,loadb,loadc,asel,bsel,vsel,write,nsel);

reg err;

task test;
    input [3:0] expected_state;

    begin
        if(fsm_tb.DUT.state !== expected_state)begin
            $display("ERROR** state is %b, expected %b",fsm_tb.DUT.state, expected_state);
            err = 1;
        end
    end
endtask

initial begin
    clk = 0; #5;
    forever begin
        clk = 1; #5;
        clk = 0; #5;
    end
end

initial begin 
    err = 0;
    reset = 0;
    #10;
    $display("checking Wait->Wait ");
    s = 0;
    #10;
    test(`Wait);

    $display("Wait->Decode");
    s = 1;
    #10;
    test(`Decode);

    $display("decode -> writeImm");
    s = 1;
    opcode = 3'b110;
    op = 2'b10;
    #10;
    test(`WriteImm);

    $display("writeImm->wait");
    #10;
    test(`Wait);

$stop;
end
endmodule
