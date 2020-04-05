`timescale 1ns / 1ns

module D_FF #(
    parameter Wid = 8
)
(
    input clk,
    input [Wid-1:0] din,
    output reg [Wid-1:0] qout
);
    
always @(posedge clk) 

begin

            qout   <= 	din;

end

endmodule