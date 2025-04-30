
module ShiftAddMult (

input	[255:0]	A,
input	[255:0]	B,
input		clk,
input		en,
input		rst_n,
output	[511:0]	out
);


//definition of registers
reg	[255:0]	multiplicand;
reg	[255:0]	mux_out;
reg	[511:0]	partial_prod;

//definition of wires
wire	[255:0] adder_out;
wire		adder_cout;

CLA256 Adder(.A(mux_out), .B(partial_prod[511:256]), .Ci(1'b0), .S(adder_out), .Cout(adder_cout), .Pout(), .Gout());

always @(posedge clk or negedge rst_n) begin

  if(!rst_n) begin
    multiplicand <= A;
    mux_out <= 256'b0;
    partial_prod <= {256'b0,B};
  end //if

  else if(en) begin
   mux_out <= partial_prod[0] ? multiplicand : 256'b0;
   partial_prod <= {adder_cout, adder_out, partial_prod[255:1]};
  end //else
end //posedge clk

assign out = partial_prod;

endmodule 