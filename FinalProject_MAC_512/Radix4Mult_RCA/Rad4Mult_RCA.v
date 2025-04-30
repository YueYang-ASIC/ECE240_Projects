
module Rad4Mult_RCA #(parameter DIGITS = 128) (

input	[(DIGITS*2)-1:0]	x,
input	[(DIGITS*2)-1:0]	y,
input				clk,
input				en,
input 				rst_n,
output	[(DIGITS*4)-1:0]	out);

reg 	[(DIGITS*4)-1:0] 	product;
reg 	[(DIGITS*4)-1:0] 	outReg;
reg 	[(DIGITS*2)-1:0] 	carry_pp;
reg 	[(DIGITS*2)-1:0] 	a;
reg 	[(DIGITS*2)-1:0] 	choose_a;
reg 	[(DIGITS*2)-1:0] 	choose_2a;
reg 				FF;		

wire	[(DIGITS*2)-1:0]	CSA1Sum;
wire 	[(DIGITS*2)-1:0]	CSA1Carry;

wire 	[(DIGITS*2)-1:0]	CSA2Sum;
wire 	[(DIGITS*2)-1:0]	CSA2Carry;

wire 	[(DIGITS*2)-1:0]	finalAdderSum;
wire 				finalAdderCout;

wire	[1:0]			carryAdderSum;
wire				carryAdderCout;


CSA #(.WIDTH(DIGITS*2)) CSA1(.x(product[(DIGITS*4)-1:(DIGITS*2)]), .y(choose_a), .z(choose_2a), .sum(CSA1Sum), .carry(CSA1Carry));
CSA #(.WIDTH(DIGITS*2)) CSA2(.x(carry_pp), .y(CSA1Sum), .z({CSA1Carry[(DIGITS*2)-2:0], 1'b0}), .sum(CSA2Sum), .carry(CSA2Carry));

RCA #(.WIDTH(DIGITS*2)) finalAdder(.x({1'b0, (product[1] & a[(DIGITS*2)-1]), CSA2Sum[(DIGITS*2)-1:2]}), .y({1'b0, (CSA1Carry[(DIGITS*2)-1] | CSA2Carry[(DIGITS*2)-1]), CSA2Carry[(DIGITS*2-2):1]}), .cin(FF), .sum(finalAdderSum), .cout(finalAdderCout));

RCA #(.WIDTH(2)) carryAdder(.x(CSA2Sum[1:0]), .y({CSA2Carry[0], FF}), .cin(1'b0), .sum(carryAdderSum), .cout(carryAdderCout));


always @(posedge clk or negedge rst_n) begin

  if(!rst_n) begin
    product <= {{(DIGITS*2){1'b0}}, y};	//initialize the product register with 0's and the multiplier
    carry_pp <= {(DIGITS*2){1'b0}};
    a <= x;					//initialize a register with multiplicand
    outReg <= {(DIGITS*4){1'b0}};
    FF <= 1'b0;
    choose_a <= {(DIGITS*2){1'b0}};
    choose_2a <= {(DIGITS*2){1'b0}};
  end //reset

  else if(en) begin
    outReg <= {finalAdderSum, carryAdderSum, product[(DIGITS*2)-1:2]};
    FF <= carryAdderCout; 
    product <= {1'b0, (product[1] & a[(DIGITS*2-1)]), CSA2Sum[(DIGITS*2)-1:2], carryAdderSum, product[(DIGITS*2)-1:2]};
    carry_pp <= {1'b0, (CSA1Carry[(DIGITS*2)-1] | CSA2Carry[(DIGITS*2)-1]), CSA2Carry[(DIGITS*2-2):1]};
    choose_a <= product[0] ? a : {(DIGITS*2){1'b0}};
    choose_2a <= product[1] ? (a << 1) : {(DIGITS*2){1'b0}};
  end //else

end //always

assign out = outReg;

endmodule 