`timescale 1ns/1ns

module barrel_shifter_tb;

parameter Wid = 8;
parameter Num = 16;

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

parameter Sel_Wid = log2(Num);

reg [Wid-1:0] inp [Num-1:0];
reg [Wid-1:0] out [Num-1:0];
reg [Wid-1:0] outreg [Num-1:0];
reg [Sel_Wid-1:0]  sel;

integer i,j;
reg clk=0;

always 
	begin
      #5  clk = ~clk;
    end

always @(posedge clk) 
begin
    outreg <= out;
end

initial 
begin
    for (i=0; i<Num; i=i+1) 
	begin
        inp[i]  = i;
    end
	sel=8;
	#10
	for (i=0; i<Num; i=i+1) 
	begin
        inp[i]  = i;
    end
	sel=7;
	#10
	for (i=0; i<Num; i=i+1) 
	begin
        inp[i]  = i;
    end
	sel=6;
	#10
	for (i=0; i<Num; i=i+1) 
	begin
        inp[i]  = i;
    end
	sel=5;
	#10
	$stop;
end

barrel_shifter #(
    .Num      (Num),
    .Wid     (Wid),
    .Rotation_wid      (Sel_Wid)
) 
b1(
    .clk        (clk),
    .reset       (rst),
    .rotate        (sel),
	.input_to_barrel_shifter        (inp),
    .output_from_barrel_shifter     (out)
);

endmodule