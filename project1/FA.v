
module FA (A,B,C,SUM,COUT);
input A;
input B;
input C;
output SUM;
output COUT;

assign SUM = A ^ B ^ C;
assign COUT = A&B | C&A | B&C;

endmodule 
