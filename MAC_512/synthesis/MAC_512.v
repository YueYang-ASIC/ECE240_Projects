// 128-bit inputs , 512-bit MAC test for 16 nm
module MAC_512(
    input           clk,
    input           rst_n,       // active-low reset
    input           en,          // enable signal
    input   [127:0] A_in,
    input   [127:0] B_in,
    output  [511:0] acc_out
);

    // Internal registered signals
    reg [127:0] A_reg, B_reg; 
    reg [511:0] acc_reg;

    // Input registers
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            A_reg <= 128'd0;
            B_reg <= 128'd0;
        end else if (en) begin
            A_reg <= A_in;
            B_reg <= B_in;
        end
    end

    // Multiply and accumulate
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin 
            acc_reg <= 512'd0;
        end else if (en) begin
            acc_reg <= acc_reg + A_reg * B_reg;          // Accumulate
        end
    end

    // Output register
    assign acc_out = acc_reg;

endmodule
