`timescale 1ns / 1ps
module RCA_8 #(parameter data_width=8) (clk,A,B,CIN,SUM,COUT);
input [data_width-1:0]	A,B; 
input CIN;
input clk;
output [data_width-1:0] SUM;
output COUT;

wire [data_width-1:0] carry;

reg [data_width-1:0] A_reg, B_reg;
reg CIN_reg;

always @(posedge clk) begin
	A_reg <= A;
	B_reg <= B;
	CIN_reg <= CIN;
end

genvar i ;
generate
	for (i = 0 ; i < data_width; i = i+1) begin
		if(i==0) begin
			FA uut0(A_reg[i],B_reg[i],CIN_reg,SUM[i],carry[i]);
		end else begin
			FA uuti(A_reg[i],B_reg[i],carry[i-1],SUM[i],carry[i]);
		end
	end
endgenerate 

assign COUT = carry[data_width-1];

endmodule 