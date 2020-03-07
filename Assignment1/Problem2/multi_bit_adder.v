`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2016 06:24:56 PM
// Design Name: 
// Module Name: multi_bit_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// E:\TA\EE599\Assignments\adder_zedd2\adder_top_tb.v
//////////////////////////////////////////////////////////////////////////////////


module multi_bit_adder
#(
    parameter   BIT_WIDTH   =   32
)
(
    input       [BIT_WIDTH-1:0]     a,
    input       [BIT_WIDTH-1:0]     b,
    input                           cin,
    output      [BIT_WIDTH-1:0]     s,
    output                          cout
    );

	wire							c[BIT_WIDTH:0];

	assign	c[0]			=	cin;
	assign  cout            =   c[BIT_WIDTH];

    genvar  i;

    generate
        for(i=0; i<BIT_WIDTH; i=i+1)    begin   :   ADD	
        	full_adder u(a[i], b[i], c[i], s[i], c[i+1]);
        end
    endgenerate
endmodule
