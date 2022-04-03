module accumulator
(
	input [3:0] A, B,
	input S, load, increment, clear,
	output [3:0] Z
);
	wire [3:0] C;
	wire [3:0] X;
	twoToOne(A, B, S, C);
	binaryCounter(C, clear, increment, load, X);
	assign Z = X;
endmodule
		

	