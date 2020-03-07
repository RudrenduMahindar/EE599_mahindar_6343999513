`timescale 1ns / 1ps


module adder_multiplier_top
#(
    parameter   BIT_WIDTH   =   8
)
(
    input                   clk,
    input                   reset,
    input   [BIT_WIDTH-1:0] input0,
    input   [BIT_WIDTH-1:0] input1,
    output  [BIT_WIDTH-1:0] output0
    );
    
    wire    [BIT_WIDTH-1:0] S;
    
    (*mark_debug="true"*)reg     [BIT_WIDTH-1:0] B;
    (*mark_debug="true"*)reg     [BIT_WIDTH-1:0] A;
    (*mark_debug="true"*)reg     [BIT_WIDTH-1:0] accumilator;    
    reg     [9:0]           counter;
    
    assign output0      =   accumilator;    
    
    
    always @(posedge clk) begin
        B     <=  input0;
        A     <=  input1;
        accumilator <= S;
    end
	
	multibit_multiplier
	#(
		.BIT_WIDTH(BIT_WIDTH)
	)
    
	multi_bit_multiplier_1
    (
        .a(A),
        .b(B),
        .s(S)
    );
	
    multi_bit_adder
    #(
        .BIT_WIDTH(BIT_WIDTH)
    )
	
    multi_bit_adder_1
    (
        .a(A),
        .b(B),
        .cin(1'b0),
        .s(S)
    );
	
    
endmodule
