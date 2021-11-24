module ALU_tb;

reg [15:0] Ain,Bin;
wire [2:0] z;
wire [15:0] out;
reg err;
reg [1:0] ALUop;

ALU DUT(Ain,Bin,ALUop,out,z); 

task test;
    input [15:0] expected_out;
    input [2:0] expected_z;

    begin 
        if(ALU_tb.DUT.out !== expected_out)begin
            $display("ERROR**out is %b,expected %b",ALU_tb.DUT.out,expected_out);
            err = 1;
        end
        if(ALU_tb.DUT.z !== expected_z)begin
            $display("ERROR**z is %b,expected %b",ALU_tb.DUT.z,expected_z);
            err = 1;
        end
    end
endtask




initial begin
    err = 0;
    #5;
    $display("checking 1+2");
    Ain = 16'b0000000000000001;
    Bin = 16'b0000000000000010;
    ALUop = 2'b00;
    #5;
    test(16'b0000000000000011,3'b000);
    #5;
    $display("checking 0 - 0");
    Ain = 16'b000000000000000;
    Bin = 16'b0000000000000000;
    ALUop = 2'b01;
    #5;
    test(16'b0000000000000000,3'b001);
    $stop;
end

endmodule
