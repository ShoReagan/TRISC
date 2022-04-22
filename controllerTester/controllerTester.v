module controllerTester(
	input w, x, y, z, clock, startStop,
	output c0, c1, c2, c3, c4, c7, c8, c9, c5, c10, c11, c12, c13, c14
);
wire LDA, STA, ADD, SUB, XOR, INC, CLR, JMP, JPZ, JPN, HLT;
	instructionDecoder(w, x, y, z, LDA, STA, ADD, SUB, XOR, INC, CLR, JMP, JPZ, JPN, HLT);
	controller(clock, startStop, LDA, STA, ADD, SUB, XOR, INC, CLR, JMP, JPZ, JPN, HLT,
				  c0, c1, c2, c3, c4, c7, c8, c9, c5, c10, c11, c12, c13, c14);
endmodule
