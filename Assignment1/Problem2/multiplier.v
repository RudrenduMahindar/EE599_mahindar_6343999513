`timescale 1ns / 1ps

module multiplier
#(
    parameter   BIT_WIDTH   =   32
)
(
    input       a,
    input       b,
    output  reg s
    );
    
    always @ (a, b)    begin
        s = a*b;
    end
endmodule
