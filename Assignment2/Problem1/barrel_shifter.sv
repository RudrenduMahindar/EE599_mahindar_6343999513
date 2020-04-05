`timescale 	1ns/1ns

module barrel_shifter # (
    parameter Num = 16,
	parameter Wid = 8,
    parameter Rotation_wid = log2(Num)
)
(	
	input 			clk,
	input 			reset,
	input           [Rotation_wid-1:0]    rotate,
	input			[Wid-1:0]   input_to_barrel_shifter     [0:Num-1],
	output 		    [Wid-1:0]   output_from_barrel_shifter      [0:Num-1]
);

function integer log2;
   
   input integer value;
   
   begin
     value = value-1;
     for (log2=0; value>0; log2=log2+1)
       value = value>>1;
   end
   
endfunction

parameter barrel_layers = log2(Num);

wire	[Wid-1:0]		barrel_output	  [0:barrel_layers-1][0:Num-1];
wire	[Wid-1:0]		barrel_input1	  [0:barrel_layers-1][0:Num-1];
wire	[Wid-1:0]		barrel_input2	  [0:barrel_layers-1][0:Num-1];

assign output_from_barrel_shifter	=	barrel_output[barrel_layers-1];
assign barrel_input1[0]   =   input_to_barrel_shifter;

genvar i, j;
generate
    
	for (i=1; i<barrel_layers; i=i+1) 
	begin
		assign barrel_input1[i] = barrel_output[i-1];
    end
	
	for (i=0; i<barrel_layers; i=i+1) 
	begin
        for (j=0; j<barrel_layers; j=j+1) 
		begin
            assign barrel_input2[i][j] = barrel_input1[i][(Num + j-(2**i))%Num];
        end
    end
	
	for (i=0; i<barrel_layers; i=i+1)
	begin
		mux # (
            .Num  	(Num),
			.Wid 	(Wid)
		)
		m1(
			.clk	(clk),
			.first_input_to_mux		(barrel_input1[i]),
			.second_input_to_mux	(barrel_input2[i]),
            .select_line        (select_barrel_input[i][i]),
			.output_from_mux		    (barrel_output[i])
		);
	end
endgenerate
	
	
reg     [Rotation_wid-1:0]        select_barrel_input 	[0:barrel_layers-1];

always @(*) 
begin
    select_barrel_input[0] = rotate;
end

generate
    for (i=1; i<barrel_layers; i=i+1) 
	begin
        always@(posedge clk) 
		begin
                select_barrel_input[i] <= select_barrel_input[i-1];
        end
    end
endgenerate

endmodule	