`timescale 1ns / 1ns

module sys_arr_tb;
parameter Matrix_Wid = 16;
parameter Data_Wid = 8;

function integer log2;
    input integer value;
    begin
        value = value - 1;
        for (log2 = 0; value > 0; log2 = log2 + 1) 
		begin
            value = value >> 1;
        end
    end
endfunction

parameter Count_Wid = log2(Matrix_Wid);

reg clk=0;

reg [Data_Wid-1:0] inp_matrix_1 [0:Matrix_Wid-1][0:Matrix_Wid-1];
reg [Data_Wid-1:0] inp_matrix_2 [0:Matrix_Wid-1][0:Matrix_Wid-1];

reg [Data_Wid-1:0] out_matrix [0:Matrix_Wid-1][0:Matrix_Wid-1];

reg start;
reg ack_rdy;

wire [Data_Wid-1:0] out [0:Matrix_Wid-1][0:Matrix_Wid-1];

wire rdy;
wire outvalid;

integer i,j;
initial 
begin
    for (i=0; i<Matrix_Wid; i=i+1) 
	begin
        for (j=0; j<Matrix_Wid; j=j+1) 
		begin
            inp_matrix_1[i][j] = i;
            inp_matrix_2[i][j] = i+j;
        end
    end
	#2
	for (i=0; i<Matrix_Wid; i=i+1) 
	begin
        for (j=0; j<Matrix_Wid; j=j+1) 
		begin
            inp_matrix_1[i][j] = i+j;
            inp_matrix_2[i][j] = j;
        end
    end
	#2
	
	$stop;
	
end	

always 
	begin
        #1	clk = ~clk;
    end

genvar r, c;
generate
    
	for (r=0; r<Matrix_Wid; r=r+1) 
	begin
        for (c=0; c<Matrix_Wid; c=c+1) 
		begin
            
			always @(posedge clk) 
			begin
                out_matrix[r][c] <= out[r][c];
            end
          
        end
    end

endgenerate

systolic_arr #(
    .Data_Wid     	(Data_Wid),
    .Matrix_Wid      (Matrix_Wid)
) syar1 
(
    .clk        (clk),
    .input1     (inp_matrix_1),
    .input2     (inp_matrix_2),
    .start      (start),
    .ack        (ackRdy),
    .output3    (out),
    .rdy       	(rdy),
    .valid      (outvalid)
);


endmodule