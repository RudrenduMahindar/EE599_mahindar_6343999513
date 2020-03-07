`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2016 03:16:53 PM
// Design Name: 
// Module Name: full_adder
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
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder
#(
    parameter   BIT_WIDTH   =   32
)
(
    input       a,
    input       b,
    input       cin,
    output  reg s,
    output  reg cout
    );
    
    always @ (a, b, cin)    begin
        {cout,s} = a + b + cin;
    end
endmodule
