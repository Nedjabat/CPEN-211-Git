module lab7_top(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,mem_cmd,mem_addr,read_data, write_data);
input [3:0] KEY;
input [9:0] SW;
input [1:0] mem_cmd;
input [8:0] mem_addr;
input [15:0] write_data;
output [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output [15:0] read_data;
wire enable;
wire [1:0] inand1, inand2, inand3;
`define MNONE   4'b00
`define MREAD   4'b01
`define MWRITE  4'b10

assign out = enable ? read_data : 16'bz;
assign inand1 = `MREAD & mem_cmd;
assign inand2 = 1'b0 & mem_addr;
assign inand3 = `MWRITE & mem_cmd;
assign write = inand2 & inand3;
assign enable = inand1 & inand2; 

RAM #(16) MEM(KEY[0],mem_addr[7:0],mem_addr[7:0],write,write_data ,out);

endmodule        

module RAM(clk,read_address,write_address,write,din,dout);
  parameter data_width = 32; 
  parameter addr_width = 4;
  parameter filename = "data.txt";

  input clk;
  input [addr_width-1:0] read_address, write_address;
  input write;
  input [data_width-1:0] din;
  output [data_width-1:0] dout;
  reg [data_width-1:0] dout;

  reg [data_width-1:0] mem [2**addr_width-1:0];

  initial $readmemb(filename, mem);

  always @ (posedge clk) begin
    if (write)
      mem[write_address] <= din;
    dout <= mem[read_address]; // dout doesn't get din in this clock cycle 
                               // (this is due to Verilog non-blocking assignment "<=")
  end 
endmodule