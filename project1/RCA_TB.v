`timescale 1ns / 1ps

module RCA_8_TB; 
    localparam data_width = 8;
    reg [data_width-1:0] A, B;
    reg CIN;
    reg CLK;
    wire [data_width-1:0] SUM;
    wire COUT;

    // Instantiate the RCA_8 module
    RCA_8 #(data_width) uut (
        .CLK(CLK),
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    // Clock Generation: 10ns period (100MHz)
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    // Test Stimulus
    initial begin : loop
        integer i;
        $display("|       A       |       B       | Cin |   Sum   | Cout | Time  |"); 

        for (i = 0; i < 10; i = i + 1) begin
            @(posedge CLK);  // Wait for positive clock edge
            A   = $random;   // Random 8-bit input A
            B   = $random;   // Random 8-bit input B
            CIN = $random % 2; // Random carry-in (0 or 1)

            @(posedge CLK);  // Wait for result after next clock cycle
            $display("| %b | %b |  %b  | %b |  %b  | %0t ns |", A, B, CIN, SUM, COUT, $time);
        end

 
        $stop;  // End simulation
    end
endmodule
