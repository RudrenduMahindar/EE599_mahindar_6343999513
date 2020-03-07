module oddeven_N
#(parameter W = 8,
            N = 16)
(
   input  [W-1:0] i [0:N-1],  // Input signals
   output [W-1:0] o [0:N-1]   // Output signals from max to min
                              // Thus o[0] is max
);   

wire [W-1:0] w [0:N*(N+1)-1];


genvar c,r,a;

generate
   for (c=0; c<N; c=c+1)
   begin
      if (c[0]==1'b0)
      begin
         for (r=0; r<N; r=r+2)
            oddeven2 oddeven2_i (.a(w[c*N+r]),.b(w[c*N+r+1]),.num_1(w[c*N+r+N]),.num_2(w[c*N+r+N+1]));            
      end
      else
      begin
         assign w[c*N+N]=w[c*N];
         for (r=1; r<N-2; r=r+2)
           oddeven2 oddeven2_i (.a(w[c*N+r]),.b(w[c*N+r+1]),.num_1(w[c*N+r+N]),.num_2(w[c*N+r+N+1]));            
         assign w[c*N+N+N-1]=w[c*N+N-1];
      end
   end
   
   for (r=0; r<N; r=r+1)
   begin
      assign w[r]=i[r];
      assign o[r]=w[N*N+r];
   end
   
endgenerate   
   
endmodule
