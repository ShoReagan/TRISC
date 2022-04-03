module binaryCounter #(parameter N=4)
(
	input [N-1:0] D,
	input clear, increment, load,
	output reg [N-1:0] Q
);
	always @ (posedge increment, negedge clear) begin
		if(clear == 0)
			Q = 0;
		else
			begin
				if (load == 1)
					Q = D;
				else
					Q <= Q + 1;
				end
	end
endmodule
			
