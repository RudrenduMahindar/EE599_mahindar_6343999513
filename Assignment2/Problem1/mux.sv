`timescale 	1ns/1ns

module mux #(
    parameter Num = 16,
    parameter Wid = 8
)
(
	input				clk,
	input 				select_line,
	input           [Wid-1:0]     first_input_to_mux     [0:Num-1],
    input           [Wid-1:0]     second_input_to_mux    [0:Num-1],
	output   reg    [Wid-1:0]     output_from_mux      	[0:Num-1]
);

genvar count_loop;

generate 
	
	for(count_loop=0;count_loop<Num;count_loop=count_loop+1)
	begin
	
		always@(posedge clk)
		begin
		
			if(select_line==1)
			begin
		
				output_from_mux[count_loop] <= second_input_to_mux[count_loop];
			
			end
			else
			begin
		
				output_from_mux[count_loop] <= first_input_to_mux[count_loop];
		
			end	
		
		end
	end	
	
endgenerate

endmodule	
	