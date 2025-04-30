
`timescale 1ns/1ps

module Rad4Mult_RCA_Test #(parameter DIGITS = 128)();

reg	[(DIGITS*2)-1:0]	x;
reg	[(DIGITS*2)-1:0]	y;
reg				clk;
reg				en;
reg 				rst_n;
wire	[(DIGITS*4)-1:0]	out;

Rad4Mult_RCA #(.DIGITS(DIGITS)) Multiplier(.x, .y, .clk, .en, .rst_n, .out);


initial begin

clk = 0;
x = 10;
y = 5;
rst_n = 1;
en = 0;

#5
rst_n = 0;

#4
rst_n = 1;
en = 1;

#1

#2575
$stop;
end


always
#10 clk = ~clk;


initial
$monitor($time, ": %d * %d = %d", x, y, out);



endmodule 
