module alu
(
	input [3:0] A, B,
	input S0, S1,
	output Cout, ovr,
	output [3:0] R,
	output [13:0] W
);
wire [3:0] addSubR, andOrR;
wire wireC, wireO;

	twoCompAddSub(A, B, S0, addSubR, wireC, wireO);
	assign andOrR = S0==0 ? A & B : A ^ B;
	assign R = S1==0 ? addSubR : andOrR;
	assign Cout = S1==0 ? wireC : 0;
	assign ovr = S1==0 ? wireO : 0;

	twoComp(R[3], R[2], R[1], R[0], W[0], W[1], W[2], W[3], W[4], W[5], W[6], W[7], W[8], W[9], 
	W[10], W[11], W[12], W[13]);
endmodule
