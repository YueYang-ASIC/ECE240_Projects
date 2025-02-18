
module RCA_8 #(parameter data_width=8) (A,B,CIN,SUM,COUT);
input [data_width-1:0]	A,B; 
input CIN;
output [data_width-1:0] SUM;
output COUT;

wire [data_width-1:0] carry;

genvar i ;
generate
	for (i = 0 ; i < data_width; i = i+1) begin
		if(i==0) begin
			FA uut0(A[i],B[i],CIN,SUM[i],carry[i]);
		end else begin
			FA uuti(A[i],B[i],carry[i-1],SUM[i],carry[i]);
		end
	end
endgenerate 

assign COUT = carry[data_width-1];

endmodule 