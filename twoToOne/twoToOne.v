module twoToOne #(parameter N=4)
(
	input [N-1:0] A, B,
	input S,
	output [N-1:0] Y
);
	assign Y = S==0 ? A : B;
endmodule
