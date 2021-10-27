
module lab3_top(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
  input [9:0] SW;
  input [3:0] KEY;
  output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
  wire [3:0] state,out;
  assign clk = ~KEY[0]; //active low buttons so not clock value
  assign reset = ~KEY[3]; //active low buttons so not reset value
  wire [3:0] in = {SW[0],SW[1],SW[2],SW[3]}; //binary number read from switches

  FSM statemachine(in,clk,reset,out,state); //instiate modules

  SEG segment(out,state,reset,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
  
endmodule