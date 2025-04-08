
`timescale 1ns/1ps

module Rad4MultTest #(parameter DIGITS = 256)();

reg	[(DIGITS*2)-1:0]	x;
reg	[(DIGITS*2)-1:0]	y;
reg				clk;
reg 				reset;
reg				done;
wire	[(DIGITS*4)-1:0]	out;

Rad4Mult #(.DIGITS(DIGITS)) Multiplier(.x, .y, .clk, .reset, .done, .out);

// Define the function to calculate delay
  function integer calc_delay;
    input integer digits;
    begin
      calc_delay = (digits - 1) * 20 + 10;
    end
  endfunction

integer delay = calc_delay(DIGITS);

initial begin

clk = 0;
x = 1;
y = 1024;
reset = 1;
done = 0;

#35
reset = 0;

#delay
done = 1;

#10
done = 0;

#10
$stop;
end


always
#10 clk = ~clk;


initial
$monitor($time, ": %d * %d = %d", x, y, out);



endmodule 
