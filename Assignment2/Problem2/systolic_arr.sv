`timescale 1ns / 1ns

module systolic_arr # (
    parameter Data_Wid = 8,
    parameter Matrix_Wid  = 16
)
(
    input           clk,
    input           [Data_Wid-1:0] input1 [0:Matrix_Wid-1][0:Matrix_Wid_-1],
    input           [Data_Wid-1:0] input2 [0:Matrix_Wid-1][0:Matrix_Wid-1],
    input           start,
    input           ack,
    output          [Data_Wid-1:0] output3 [0:Matrix_Wid-1][0:Matrix_Wid-1],
    output          rdy,
    output          valid
);

function integer log2;
   
   input integer value;
   
   begin

     value = value-1;
     for (log2=0; value>0; log2=log2+1)
       value = value>>1;

   end
   
endfunction

parameter Count_Wid = log2(Matrix_Wid); 

reg [Count_Wid-1:0] index;
wire [Matrix_Wid-1:0] outdone [0:Matrix_Wid-1];
wire [Matrix_Wid-1:0] restart [0:Matrix_Wid-1];
wire [Count_Wid-1:0] count [0:Matrix_Wid-1];

assign restart[0][0] = start && rdy; 
assign outdone[0][0] = (count[0] == Matrix_Wid);
assign count[0] = index;

wire [Matrix_Wid:0] inp_valid [0:Matrix_Wid-1];
wire [Data_Wid-1:0] inputSysArray1 [0:Matrix_Wid-1][0:Matrix_Wid-1];
wire [Data_Wid-1:0] inputSysArray2 [0:Matrix_Wid-1][0:Matrix_Wid-1];
wire [Data_Wid-1:0] outputSysArray1 [0:Matrix_Wid-1][0:Matrix_Wid-1];
wire [Data_Wid-1:0] outputSysArray2 [0:Matrix_Wid-1][0:Matrix_Wid-1];


genvar i, j;
generate
    for (i=1; i<Matrix_Wid; i=i+1) 
	begin
        D_FF dd1 (.clk(clk), .din(outdone[0][i-1]), .qout(outdone[0][i])); 
        D_FF dd2 (.clk(clk), .din(restart[0][i-1]), .qout(restart[0][i]));
        D_FF #(Count_Wid) dd3 (.clk(clk), .din(count[i-1]), .qout(cnt[i]));
    end
    for (i=1; i<Matrix_Wid; i=i+1) 
	begin
        for (j=0; j<Matrix_Wid; j=j+1) 
		begin
            D_FF dd4 (.clk(clk), .din(restart[i-1][j]), .qout(restart[i][j]));
            D_FF dd5 (.clk(clk), .din(outdone[i-1][j]), .qout(outdone[i][j]));
        end
    end
endgenerate

assign valid = (outdone[Matrix_Wid-1][Matrix_Wid-1]); 

always @(posedge clk) 
begin
     
    if (!outdone[Matrix_Wid-1][Matrix_Wid-1])
    begin             
        if (start)
            index     <= 0;
        else if (index < Matrix_Wid)
            index     <= index + 1;
    end
        
end

assign inp_valid[0][0] = (count[0] < Matrix_Wid) || (start);
assign inputSysArray1[0][0] = input1[0][count[0]];
assign inputSysArray2[0][0] = input2[count[0]][0];

generate
    for (i=1; i<Matrix_Wid; i=i+1) 
	begin
        D_FF DFF1 (.clk(clk), .din(inp_valid[i-1][0]), .qout(inp_valid[i][0]));
        assign inputSysArray1[i][0] = input1[i][count[i]];
        assign inputSysArray2[0][i] = input2[count[i]][i];
    end
    for (i=0; i<Matrix_Wid; i=i+1) 
	begin
        for (j=1; j<Matrix_Wid; j=j+1) 
		begin
            assign inputSysArray1[i][j] = outputSysArray1[i][j-1];
        end
    end
    for (i=1; i<Matrix_Wid; i=i+1) 
	begin
        for (j=0; j<Matrix_Wid; j=j+1) 
		begin
            assign inputSysArray2[i][j] = outputSysArray2[i-1][j];
        end
    end
    
    for (i=0; i<Matrix_Wid; i=i+1) 
	begin
        for (j=0; j<Matrix_Wid; j=j+1) 
		begin
            array_block # (Data_Wid)
			ab_1
            (
                .clk(clk),
                .input1(inputSysArray1[i][j]),
                .input2(inputSysArray2[i][j]),
                .restart(restart[i][j]),
                .output1(outputSysArray1[i][j]),
                .output2(outputSysArray2[i][j]),
                .output3(output3[i][j])
            );
        end
    end
endgenerate
endmodule