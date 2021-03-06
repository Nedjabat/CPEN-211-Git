module regfile(data_in,writenum,write,readnum,clk,data_out);
input [15:0] data_in;
input [2:0] writenum, readnum;
input write, clk;
output [15:0] data_out; 
wire [7:0] writenumout, regselect;
wire [15:0] R0,R1,R2,R3,R4,R5,R6,R7;
reg [15:0] data_out;

Dec  decoder1(writenum,writenumout); //instantiate decoder to convert writenum into onehot

register Reg0(data_in,writenumout[0] & write,clk,R0); //instantiate reg modules for each register
register Reg1(data_in,writenumout[1] & write,clk,R1);
register Reg2(data_in,writenumout[2] & write,clk,R2);
register Reg3(data_in,writenumout[3] & write,clk,R3);
register Reg4(data_in,writenumout[4] & write,clk,R4);
register Reg5(data_in,writenumout[5] & write,clk,R5);
register Reg6(data_in,writenumout[6] & write,clk,R6);
register Reg7(data_in,writenumout[7] & write,clk,R7);

assign regselect = 1<< readnum; //decoder to conver readnum into onehot

always @(*)begin //multiplexer for 8 registers
        case(regselect) 
        8'b00000001: data_out = R0;
        8'b00000010: data_out = R1;
        8'b00000100: data_out = R2;
        8'b00001000: data_out = R3;
        8'b00010000: data_out = R4;
        8'b00100000: data_out = R5;
        8'b01000000: data_out = R6;
        8'b10000000: data_out = R7;
        default : data_out = 16'bxxxxxxxxxxxxxxxx;
        endcase
	end
endmodule


module Dec(a,b);  //3:8 decoder to convert wrtienum into one hot code
  input[2:0]a;
  output[7:0]b;

  wire [7:0]b= 1 << a;
endmodule


module register(in,load,clk,out); //reister 
    input [15:0] in;
    input load, clk;
    output [15:0] out;
    wire [15:0] next_out;
    reg [15:0] out;

    assign next_out = load ? in : out; //multiplexer
    
    always @(posedge clk)begin  //flipflop
    out = next_out;
    end

endmodule


