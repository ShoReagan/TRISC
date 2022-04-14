//RAM tester and loader
module RAMtester2
(
	input clear, RAMclock, clock, clock_enable, RW, 
	input [1:0] mode,
	input [7:0] DataIn, 
	output [9:0] DataInLEDR,
	output [6:0] AddressOut,
	output [13:0] DataOut
);
	wire toggle, clock1;
	wire [7:0] Data, Data1;
	wire [3:0] Address;
	assign DataInLEDR = {mode, DataIn};
	assign Data1 = mode[1]==0 ? (mode[0]==0 ? DataIn : 8'h00) : (mode [0]==0 ? 8'hFF : {~Address, Address});
	assign clock1 = mode[1]==0 ? (mode[0]==0 ? RAMclock : clock*~clock_enable) : (mode[0]==0 ? clock*~clock_enable : clock*~clock_enable);
	
//Module instantiations

OnOffToggle DivideX2
(
	.OnOff(clock1) ,		// input  OnOff_sig
	.IN(1'b1) ,				// input  IN_sig
	.OUT(toggle) 			// output  OUT_sig
);

BinUp AddressGen
(
	.inc(toggle) ,			// input  inc_sig
	.clear(clear) ,		// input  clear_sig
	.load(1'b1) ,			// input  load_sig
	.D(4'b0) ,				// input [N-1:0] D_sig
	.Q(Address) 			// output [N-1:0] Q_sig
);

Lab11RAM	Lab11RAM 
(
	.address (Address),
	.clock (~clock1),
	.data (Data1),
	.wren (~RW),
	.q (Data)
);
	
binary2seven Address_HEX2
(
	.w(Address[3]) ,	// input  w_sig
	.x(Address[2]) ,	// input  x_sig
	.y(Address[1]) ,	// input  y_sig
	.z(Address[0]) ,	// input  z_sig
	.a(AddressOut[0]) ,	// output  a_sig
	.b(AddressOut[1]) ,	// output  b_sig
	.c(AddressOut[2]) ,	// output  c_sig
	.d(AddressOut[3]) ,	// output  d_sig
	.e(AddressOut[4]) ,	// output  e_sig
	.f(AddressOut[5]) ,	// output  f_sig
	.g(AddressOut[6]) 	// output  g_sig
);

binary2seven High_data_HEX1
(
	.w(Data[7]) ,		// input  w_sig
	.x(Data[6]) ,		// input  x_sig
	.y(Data[5]) ,		// input  y_sig
	.z(Data[4]) ,		// input  z_sig
	.a(DataOut[7]) ,	// output  a_sig
	.b(DataOut[8]) ,	// output  b_sig
	.c(DataOut[9]) ,	// output  c_sig
	.d(DataOut[10]) ,	// output  d_sig
	.e(DataOut[11]) ,	// output  e_sig
	.f(DataOut[12]) ,	// output  f_sig
	.g(DataOut[13]) 	// output  g_sig
);

binary2seven Low_data_HEX0
(
	.w(Data[3]) ,		// input  w_sig
	.x(Data[2]) ,		// input  x_sig
	.y(Data[1]) ,		// input  y_sig
	.z(Data[0]) ,		// input  z_sig
	.a(DataOut[0]) ,	// output  a_sig
	.b(DataOut[1]) ,	// output  b_sig
	.c(DataOut[2]) ,	// output  c_sig
	.d(DataOut[3]) ,	// output  d_sig
	.e(DataOut[4]) ,	// output  e_sig
	.f(DataOut[5]) ,	// output  f_sig
	.g(DataOut[6]) 		// output  g_sig
);
endmodule 