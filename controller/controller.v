module controller(
	input clock, startStop, LDA, STA, ADD, SUB, XOR, INC, CLR, JMP, JPZ, JPN, HLT,
	output reg c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14
);
	
	reg [4:0] state, nextstate;
	parameter A=5'b00000, B=5'b00001, C=5'b00010, D=5'b00011, E=5'b00100, F=5'b00101, G=5'b00110, H=5'b00111, I=5'b01000, J=5'b01001,
				 K=5'b01010, L=5'b01011, M=5'b01100, N=5'b01101, O=5'b01110, P=5'b01111, Q=5'b10000, R=5'b10001, S=5'b10010, T=5'b10011,
				 U=5'b10100;
	always @ (negedge clock, negedge startStop)
		if(startStop == 0)
			state <= A;
		else
			state <= nextstate;
	always @ (state, LDA, STA, ADD, SUB, XOR, INC, CLR, JMP, JPZ, JPN, HLT)
		case(state)
			A: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b10000000000000; nextstate = B; end
			B: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00010000000000; nextstate = C; end
			C: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00011000000000; nextstate = D; end
			D: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00011000000000; nextstate = E; end
			E: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00110100000000;
				if(INC) nextstate = F;
					else if(CLR) nextstate = G;
						else if(JMP) nextstate = H;
							else if(LDA) nextstate = I;
								else if(STA) nextstate = M;
									else if(ADD) nextstate = P;
				end
			F:	begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000001000000; nextstate = B; end
			G: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000010000000; nextstate = B; end
			H: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b01000000000000; nextstate = B; end
			I: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = J; end
			J: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00001000000000; nextstate = K; end
			K: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00001000000000; nextstate = L; end
			L: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000001000; nextstate = B; end
			M: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			N: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			O: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			P: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			Q: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			R: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			S: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			T: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
			U: begin {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14} = 14'b00000000000000; nextstate = B; end
	endcase
endmodule
		