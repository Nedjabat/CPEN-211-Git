module CPU_tb;

    reg  clk, reset, s, load;
    reg [15:0] in;
    wire [15:0] out;
    wire N, V, Z, w;


    cpu DUT(clk,reset,s,load,in,out,N,V,Z,w);

    reg err=0; 

    task my_checker;
        input [15:0] expected_out;
        begin
            if(CPU_tb.DUT.out !== expected_out)
        begin
            $display ("ERROR out is %b, expected %b", CPU_tb.DUT.out, expected_out);
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
    reset = 0;
    s = 1;
    in = 16'b0000000000000001;
    load = 0;
    #20
    load = 1;
    #200
    my_checker(16'b1000000000000100);
    $stop;
    end
    endmodule