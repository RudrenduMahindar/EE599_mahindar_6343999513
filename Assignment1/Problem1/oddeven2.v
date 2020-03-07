module oddeven2 
#(parameter BW = 8)
(
   input  [BW-1:0] a,
   input  [BW-1:0] b,
   output [BW-1:0] num_1,
   output [BW-1:0] num_2
   );

wire comparator;

   assign comparator = a>b;
   assign num_1= comparator ? a : b;
   assign num_2= comparator ? b : a;
endmodule   
   
   