module pInPOut #(parameter N = 4)
(
	input [N-1:0] D,
	input clear, load,
	output reg [N-1:0] Q
);
	always @ (negedge load, negedge clear) begin
		if(clear == 0)
			Q = 4'b0000;
		else if(load == 0)
			Q = D;
	end
	
endmodule
