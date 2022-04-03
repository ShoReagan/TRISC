module twoCompAddSub
(
	input [3:0] A, B,
	input addOrSub,
	output [3:0] S,
	output Cout, ovr
);
	wire [4:0] C;
	assign C[0] = addOrSub;
		FAbehav(A[0], B[0]^C[0], C[0], S[0], C[1]);
		FAbehav(A[1], B[1]^C[0], C[1], S[1], C[2]);
		FAbehav(A[2], B[2]^C[0], C[2], S[2], C[3]);
		FAbehav(A[3], B[3]^C[0], C[3], S[3], C[4]);
		assign Cout = C[4];
		assign ovr = C[3] ^ C[4];
endmodule
