module FPU_Main (
    input clk,
    input [31:0] A,
    input [31:0] B,
    input [1:0] S,
    output reg [31:0] O
);

    
    parameter [1:0] Addition = 2'b00,
                    SQRT = 2'b01,
                    Multiplication = 2'b10,
                    Division = 2'b11;

    wire [31:0] add, sqrt, mul, div; 
   
    FloatingAddition FPUA(.clk(clk), .A(A), .B(B), .result(add));
    FloatingSqrt FPUS(.clk(clk), .A(A), .result(sqrt));
    FloatingMultiplication FPUM(.clk(clk), .A(A), .B(B), .result(mul));
    FloatingDivision FPUD(.clk(clk), .A(A), .B(B), .result(div));

    always @ (posedge clk)
        begin

            case (S)
                Addition:
                    begin
                        O = add;
                        
                    end
                SQRT:
                    begin
                        O = sqrt;
                        
                    end
                Multiplication:
                    begin
                        O = mul;
                        
                    end
                Division:
                    begin
                        O = div;
                        
                    end
            endcase

        end

endmodule

