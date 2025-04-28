


module CLA4_clk(
    input           clk,
    input           rst_n,       // active-low reset
    input           en,          // enable signal
    input     A_in,
    input     B_in,
    output    res
);

    // Internal registered signals
    reg  A_reg, B_reg; 
    reg  res_reg;

    //Internal wire signals
    wire   CLA_sum; 


    // Input registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A_reg <= 1'd0;
            B_reg <= 1'd0;
        end else if (en) begin
            A_reg <= A_in;
            B_reg <= B_in;
        end
    end 
 
  CLA4 CLA(.A(A_reg), .B(B_reg), .Ci(1'b0), .S(CLA_sum), .Cout());

    // Multiply and accumulate
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin 
            res_reg <= 1'd0;
        end else if (en) begin
            res_reg <= CLA_sum;          // Accumulate
        end
    end

    // Output register
    assign res = res_reg;

endmodule 
