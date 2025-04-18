module FloatingAddition #(parameter XLEN=32) 
                        (input [XLEN-1:0] A,
                         input [XLEN-1:0] B,
                         input clk,
                         output reg [XLEN-1:0] result);

    // Internal registers
    reg [23:0] A_Mantissa, B_Mantissa, Temp_Mantissa;
    reg [22:0] Mantissa;
    reg [7:0] A_Exponent, B_Exponent, diff_Exponent, exp_adjust, Exponent;
    reg A_sign, B_sign, Sign;
    reg carry;
    reg comp;

    always @(posedge clk) begin
        // Step 1: Compare exponents
        comp = (A[30:23] >= B[30:23]) ? 1'b1 : 1'b0;

        // Step 2: Extract components
        A_Mantissa = comp ? {1'b1, A[22:0]} : {1'b1, B[22:0]};
        A_Exponent = comp ? A[30:23] : B[30:23];
        A_sign     = comp ? A[31]    : B[31];

        B_Mantissa = comp ? {1'b1, B[22:0]} : {1'b1, A[22:0]};
        B_Exponent = comp ? B[30:23] : A[30:23];
        B_sign     = comp ? B[31]    : A[31];

        // Step 3: Align exponents
        diff_Exponent = A_Exponent - B_Exponent;
        B_Mantissa = B_Mantissa >> diff_Exponent;

        // Step 4: Add or subtract mantissas
        {carry, Temp_Mantissa} = (A_sign ~^ B_sign) ? 
                                  A_Mantissa + B_Mantissa : 
                                  A_Mantissa - B_Mantissa;

        // Step 5: Normalize
        exp_adjust = A_Exponent;
        if (carry) begin
            Temp_Mantissa = Temp_Mantissa >> 1;
            exp_adjust = exp_adjust + 1;
        end else begin  : normalize_mantissa  //  'integer i' needed to be in a named block.
            integer i; // synthesizable instead of a 'while loop'
            reg done; // not a register , to replace 'break'
            done = 0;
            for (i = 0; i < 24; i = i + 1) begin
                if (!Temp_Mantissa[23] && !done) begin
                    Temp_Mantissa = Temp_Mantissa << 1;
                    exp_adjust = exp_adjust - 1;
                end else begin
                    done = 1;
                end
            end
        end

        // Step 6: Assemble final result
        Sign = A_sign;
        Mantissa = Temp_Mantissa[22:0];
        Exponent = exp_adjust;
        result = {Sign, Exponent, Mantissa};
    end
endmodule

