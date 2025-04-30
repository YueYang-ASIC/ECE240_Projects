

module MAC512_SA_RCA_Test ();

reg	[255:0]	A;
reg	[255:0]	B;
reg		clk;
reg		en;
reg		rst_n;
wire	[511:0]	out;


MAC512_SA_RCA myMAC(.A, .B, .clk, .en, .rst_n, .out);


initial begin
A <= 5;
B <= 10;
clk <= 0;
en <= 0;
rst_n <= 1;


#5
rst_n <= 0;

#4
en <= 1;
rst_n <= 1;

#1


#5130
A <= 1;
B <= 5;

#5140
A <= 2;
B <= 2;

#5275
$stop;

end

always
#10 clk = ~clk;

initial
$monitor($time,": %d * %d = %d", A, B, out);


endmodule 