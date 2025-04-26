module CLA32(A,B,Ci,S,Cout);

localparam n = 32; // 128bit CLA

input [n-1:0] A;
input [n-1:0] B;
input Ci;

output [n-1:0] S;

output Cout;

/* CLA generator intermediate wires */
wire [1:0] P;  
wire [1:0] G; 
wire 	   C; 
 
/* Instantiate 4 CLA_4bit addter to generater corresponding signals */
CLA16 CLA0(.A(A[(n/2)-1:0]),.B(B[(n/2)-1:0]),.Ci(Ci),.S(S[(n/2)-1:0]),.Cout(),.Pout(P[0]),.Gout(G[0])); 
CLA16 CLA1(.A(A[2*(n/2)-1:(n/2)]),.B(B[2*(n/2)-1:(n/2)]),.Ci(C),.S(S[2*(n/2)-1:(n/2)]),.Cout(),.Pout(P[1]),.Gout(G[1]));  

assign C = G[0] | Ci & P[0];
assign Cout = G[1] | (G[0] & P[1]) | (P[1] & P[0] & Ci);
 
endmodule 
