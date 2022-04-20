module instructionDecoder (
	input w,x,y,z,
	output reg a, b, c, d, e, f, g, h, i, j, k);
	always @ (w,x,y,z) begin
		case({w,x,y,z})
			4'b0000: {a,b,c,d,e,f,g, h, i, j, k} = 11'b10000000000;
			4'b0001: {a,b,c,d,e,f,g, h, i, j, k} = 11'b01000000000;
			4'b0010: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00100000000;
			4'b0011: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00010000000;
			4'b0100: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00001000000;
			4'b0110: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00000100000;
			4'b0111: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00000010000;
			4'b1000: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00000001000;
			4'b1100: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00000000100;
			4'b1001: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00000000010;
			4'b1111: {a,b,c,d,e,f,g, h, i, j, k} = 11'b00000000001;
		endcase
	end
endmodule
