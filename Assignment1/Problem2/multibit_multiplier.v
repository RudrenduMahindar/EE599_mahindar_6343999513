`timescale 1ns / 1ps

module multi_bit_multiplier
#(
    parameter   BIT_WIDTH   =   32
)
(
    input       [BIT_WIDTH-1:0]     a,
    input       [BIT_WIDTH-1:0]     b,
    output      [BIT_WIDTH-1:0]     s
);


    genvar  i;

    generate
        for(i=0; i<BIT_WIDTH; i=i+1)  begin : MULTIPLY	
        	multiplier u(a[i], b[i], s[i]);
        end
    endgenerate

endmodule
