
module MAC512_SA_RCA (

input	[255:0]	A,
input	[255:0]	B,
input		clk,
input		en,
input		rst_n,
output	[511:0]	out
);

reg		state;
reg	[8:0]	counter_reg;
reg	[255:0] A_reg;
reg	[255:0] B_reg;
reg	[511:0] adder_in_reg;
reg	[511:0] partial_reg;

wire		adder_cout;
wire	[511:0] adder_out;
wire	[511:0] mult_out;


ShiftAddMult multiply(.A(A_reg), .B(B_reg), .clk(clk), .en(en), .rst_n(state), .out(mult_out));
RCA #(.WIDTH(512)) adder(.x(partial_reg), .y(adder_in_reg), .cin(1'b0), .sum(adder_out), .cout());


always @(posedge clk or negedge rst_n) begin

  if(!rst_n) begin
    A_reg = A;
    B_reg = B;
    state <= 1'b0;
    counter_reg <= 9'b0;
    adder_in_reg <= 512'b0;
    partial_reg <= 512'b0;
  end
  
  else if(en) begin
    case(state)
      0: begin
        state <= 1'b1;
        counter_reg <= 9'b0;
        adder_in_reg <= 512'b0;
      end //0
      1: begin
        if(counter_reg == 257) begin
          counter_reg <= 9'b0;
          adder_in_reg <= mult_out;
          A_reg <= A;
          B_reg <= B;
          state <= 1'b0;
        end //if
        else
          counter_reg <= counter_reg + 9'b1;
      end //1
    endcase
    partial_reg <= adder_out;
  end //en

end //posedge

assign out = partial_reg;

endmodule 