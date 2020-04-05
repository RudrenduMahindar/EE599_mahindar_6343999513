`timescale 		1ns / 1ns


module array_block #(
    parameter Wid = 8
)
(
    input                           clk,
    input           [Wid-1:0]     	input1,
    input           [Wid-1:0]     	input2,
    input                           restart, 
    output reg      [Wid-1:0]     	output1,
    output reg      [Wid-1:0]     	output2,
    output reg      [Wid-1:0]     	output3
);




always @(posedge clk) 

begin

            output1        <= 		input1;
            output2        <= 		input2;
            output3        <= 		(restart ? 0 : (output3 + input1*input2));

end


endmodule