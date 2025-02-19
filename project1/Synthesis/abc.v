// abc.v
//
// practice

`timescale 10ps/1ps
`celldefine
module abc (
   in0,
   in1,
   out,
   a,
   b,
   in31a, in31b, out32,
   reset,
   clk
   );

   //----- Inputs/outputs
   input  [1:0]		in0;
   input  [1:0]		in1;
   output [2:0]         out;

   input                a;
   output               b;

   input  [30:0]	in31a;
   input  [30:0]	in31b;
   output [31:0]	out32;

   input                reset;
   input                clk;


   //----- 2-bit adder
   reg  [1:0]   r_in0, r_in1;
   reg  [2:0]   out;
   wire [2:0]   c_out;

   //assign c_out = r_in0 + r_in1;
   assign c_out = {r_in0[1], r_in0} + {r_in1[1], r_in1};

   always @(posedge clk) begin
      r_in0     <= #1 in0;
      r_in1     <= #1 in1;
      out       <= #1 c_out;
      if (reset == 1'b1) begin    // logic here is breaking a guideline...
         out       <= #1 2'b00;
      end
   end

   //----- just a 2-FF delay line
   wire         b;

   def def1 (
      .in       (a),
      .out      (b),
      .clk      (clk)
      );

   //----- 32-bit adder
   reg  [30:0]   r_in31a, r_in31b;
   reg  [31:0]   out32;
   wire [31:0]   c_out32;

   assign c_out32 = {r_in31a[30], r_in31a} + {r_in31b[30], r_in31b};

   always @(posedge clk) begin
      r_in31a   <= #1 in31a;
      r_in31b   <= #1 in31b;
      out32     <= #1 c_out32;
   end

endmodule   /* abc */
`endcelldefine
