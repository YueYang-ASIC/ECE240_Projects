
module MAC_512_CLA_tb;

reg           clk;
reg           rst_n;       // active-low reset
reg           en;          // enable signal
reg   [127:0] A_in;
reg   [127:0] B_in;
wire  [511:0] acc_out;

 MAC_512_CLA uut (.clk, .rst_n, .en, .A_in, .B_in, .acc_out);

initial begin
clk <= 0;
rst_n <= 0;
en <=0;

A_in <= 3;
B_in <= 7;
#10 en<= 1;
rst_n <= 1;

#100 $stop;


end

always begin
#5 clk = ~clk;
end

endmodule 