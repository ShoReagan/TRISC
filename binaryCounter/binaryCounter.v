module binaryCounter #(parameter N=4)
(
	input [N-1:0] D,
	input clear, increment, load,
	output reg [N-1:0] Q
);
	always @ (negedge increment, negedge clear, negedge load) begin
		if(clear == 0)
			Q = 4'b0000;
		else if(load == 0)
			Q = D;
		else
			Q <= Q + 1;
	end
endmodule
			
