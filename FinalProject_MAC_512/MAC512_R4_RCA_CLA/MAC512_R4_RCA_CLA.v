
module MAC512_R4_RCA_CLA (

input	[255:0]	A,
input	[255:0]	B,
input		clk,
input		en,
input		rst_n,
output	[511:0]	out
);

reg		state;
reg	[7:0]	counter_reg;
reg	[255:0] A_reg;
reg	[255:0] B_reg;
reg	[511:0] adder_in_reg;
reg	[511:0] partial_reg;

wire		adder_cout;
wire	[511:0] adder_out;
wire	[511:0] mult_out;


Rad4Mult_RCA multiply(.x(A_reg), .y(B_reg), .clk(clk), .en(en), .rst_n(state), .out(mult_out));
CLA512 adder(.A(partial_reg), .B(adder_in_reg), .Ci(1'b0), .S(adder_out), .Cout());


always @(posedge clk or negedge rst_n) begin

  if(!rst_n) begin
    A_reg = A;
    B_reg = B;
    state <= 1'b0;
    counter_reg <= 8'b0;
    adder_in_reg <= 512'b0;
    partial_reg <= 512'b0;
  end
  else if(en) begin
    case(state)
      0: begin
        state <= 1'b1;
        counter_reg <= 8'b0;
        adder_in_reg <= 512'b0;
      end //0
      1: begin
        if(counter_reg == 129) begin
          counter_reg <= 8'b0;
          adder_in_reg <= mult_out;
          A_reg <= A;
          B_reg <= B;
          state <= 1'b0;
        end //if
        else
          counter_reg <= counter_reg + 8'b1;
      end //1
    endcase
    partial_reg <= adder_out;
  end

end //posedge

assign out = partial_reg;

endmodule 