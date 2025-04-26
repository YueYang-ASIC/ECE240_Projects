module CLA32_clk(
    input           clk,
    input           rst_n,       // active-low reset
    input           en,          // enable signal
    input   [31:0] A_in,
    input   [31:0] B_in,
    output  [31:0] res
);

    // Internal registered signals
    reg [31:0] A_reg, B_reg; 
    reg [31:0] res_reg;

    //Internal wire signals
    wire [31:0] CLA_sum; 


    // Input registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A_reg <= 32'd0;
            B_reg <= 32'd0;
        end else if (en) begin
            A_reg <= A_in;
            B_reg <= B_in;
        end
    end 
 
  CLA32 CLA(.A(A_reg), .B(B_reg), .Ci(1'b0), .S(CLA_sum), .Cout());

    // Multiply and accumulate
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin 
            res_reg <= 32'd0;
        end else if (en) begin
            res_reg <= CLA_sum;          // Accumulate
        end
    end

    // Output register
    assign res = res_reg;

endmodule 
