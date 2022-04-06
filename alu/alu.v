module alu
(
	input [3:0] A, B,
	input S0, S1,
	output Cout, ovr,
	output [3:0] R
);
		if(S1 == 0)
			twoCompAddSub(A, B, S0, R, Cout, ovr);
		else
			begin
				if(S0 == 0)
					assign R = A & B;
				else
					assign R = A ^ B;
				assign Cout = 0;
				assign ovr = 0;
			end
		twoComp(R[0], R[1], R[2], R[3]);
endmodule
