module xor_2T (output XxorY, input X, input X_bar, input Y);
  wire net1,net2;
  // Pass transistor logic
 /   nmos1v (net1, X_bar, Y);    // NMOS transistor: Y controls passing X_bar
     pmos1v (net2, X, Y); // PMOS transistor: Y controls passing the complement
  assign XxorY = net1 | net2;
 endmodule
 
