module FA(
input  x,
input  y,
input  cin,
output out,
output cout
);

assign out = (x ^ y) ^ cin;
assign cout = (x & y) | (x & cin) | (y & cin);

endmodule

