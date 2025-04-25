

module MAC512_R4_RCA_Test ();

reg	[255:0]	A;
reg	[255:0]	B;
reg		clk;
reg		en;
reg		rst_n;
wire	[511:0]	out;


MAC512_R4_RCA myMAC(.A, .B, .clk, .en, .rst_n, .out);


initial begin
A <= 32;
B <= 32;
clk <= 0;
en <= 0;
rst_n <= 1;


#5
rst_n <= 0;

#4
en <= 1;
rst_n <= 1;

#1


#2590
A <= 5;
B <= 10;

#2600
A <= 100;
B <= 100;

#2915
$stop;

end

always
#10 clk = ~clk;

initial
$monitor($time,": %d * %d = %d", A, B, out);


endmodule 