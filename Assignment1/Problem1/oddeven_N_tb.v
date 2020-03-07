module oddeven_N_tb;

localparam W= 8; // Data width
localparam N= 16; // Number of signals


reg  [W-1:0] i [0:N-1];
wire [W-1:0] o [0:N-1];

integer l;

   initial
   begin
      for (l=0; l<N; l=l+1)
        i[l]  = N-l;
      #100;
      
      for (l=0; l<N; l=l+1)
        i[l]  = l%(N/2);
      #100;
     
      for (l=0; l<N; l=l+1)
        i[l]  = l;
      #100;
 
       for (l=0; l<N; l=l+1)
        i[l]  = $random();
      #100;
     
      $stop;
   end


oddeven_N
   #(
      .W (W),  // Data width
      .N (N)
   )
oddeven_N_0 (
      .i(i),
      .o(o) 
   );
   
endmodule
