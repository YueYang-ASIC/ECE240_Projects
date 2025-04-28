module RCA_clk #(parameter WIDTH = 512)(
    input           clk,
    input           rst_n,       // active-low reset
    input           en,          // enable signal
    input   [WIDTH-1:0] A_in,
    input   [WIDTH-1:0] B_in,
    output  [WIDTH-1:0] res
);

    // Internal registered signals
    reg [WIDTH-1:0] A_reg, B_reg, res_reg;

    //Internal wire signals
    wire [WIDTH-1:0] RCA_sum; 
 
    // Input registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A_reg <=  {WIDTH{1'b0}};
            B_reg <=  {WIDTH{1'b0}};
            res_reg <=  {WIDTH{1'b0}};
        end else if (en) begin
            A_reg <= A_in;
            B_reg <= B_in;
            res_reg <= RCA_sum;          // Accumulate
        end
    end 
 
 

RCA #(.WIDTH(WIDTH)) uut (
    .x(A_reg), 
    .y(B_reg), 
    .cin(1'b0), 
    .sum(RCA_sum), 
    .cout()
);
 
    // Output register
    assign res = res_reg;

endmodule 
