module trisc2(
	input Mode, ClockIn, ClearAddGen, RW, //Mode = SW9, ClockIn = Key2, ClearAddGen = Key3, RW = Key5
	input [7:0]    DataIn,					  //DataIn = {SW7,SW6,SW5,SW4,SW3,SW2,SW1,SW0}
	input startStop, clock,
	output[6:0] PChex, MARhex,
	output[13:0] MDout, MDin,
	output c0, c1, c2, c3, c4, c5, c7, c8, c9, c10, c11, c12, c13, c14
);

wire [3:0]      AddIn, AddGen; 
wire RAMin, RAMwrite, toggle; 
wire [7:0]      RAMdata; 

wire[7:0] MDI, MDO;
wire[3:0] addressBus;
wire[3:0] RAMadd;

  
assign AddIn = Mode == 1'b0 ? RAMadd : AddGen; 
assign RAMin = Mode == 1'b0 ? clock*c4 : ClockIn; 
assign RAMdata = Mode == 1'b0 ? MDI : DataIn; 
assign RAMwrite = Mode == 1'b0 ? c5 : ~RW; 
  
OnOffToggle DivideX2 
( 
 .OnOff(ClockIn) ,   // input  OnOff_sig 
 .IN(1'b1) ,    // input  IN_sig 
 .OUT(toggle)     // output  OUT_sig 
); 
BinUp AddressGen 
( 
 .inc(toggle) ,    // input  inc_sig 
 .clear(ClearAddGen) ,   // input  clear_sig 
 .load(1'b1) ,    // input  load_sig 
 .D(4'b0) ,    // input  [N-1:0] D_sig 
 .Q(AddGen)     // output [N-1:0] Q_sig 
); 
Lab11RAM RAM 
( 
 .address ( AddIn ), 
 .clock ( ~RAMin ), 
 .data ( RAMdata ), 
 .wren ( RAMwrite ), 
 .q ( MDO ) 
);

wire[3:0] irToCu;
wire Cout, ovr;
wire[3:0] aluToBuffer;
wire[3:0] accToAlu;
wire[3:0] bufferToAcc;
wire[13:0] holder;

assign RAMadd = c3 == 1 ? addressBus[3:0] : MDO[3:0]; 

pInPOut IR
(
	.D(MDO[7:4]) ,	// input [N-1:0] D_sig
	.clear(1'b1) ,	// input  clear_sig
	.load(~c7) ,	// input  load_sig
	.Q(irToCu) 	// output [N-1:0] Q_sig
);

defparam IR.N = 4;

controllerTester controllerTester_inst
(
	.w(irToCu[3]) ,	// input  w_sig
	.x(irToCu[2]) ,	// input  x_sig
	.y(irToCu[1]) ,	// input  y_sig
	.z(irToCu[0]) ,	// input  z_sig
	.clock(~clock) ,	// input  clock_sig
	.startStop(startStop) ,	// input  startStop_sig
	.c0(c0) ,	// output  c0_sig
	.c1(c1) ,	// output  c1_sig
	.c2(c2) ,	// output  c2_sig
	.c3(c3) ,	// output  c3_sig
	.c4(c4) ,	// output  c4_sig
	.c7(c7) ,	// output  c7_sig
	.c8(c8) ,	// output  c8_sig
	.c9(c9) ,	// output  c9_sig
	.c5(c5) ,	// output  c5_sig
	.c10(c10) ,	// output  c10_sig
	.c11(c11) ,	// output  c11_sig
	.c12(c12) ,	// output  c12_sig
	.c13(c13) ,	// output  c13_sig
	.c14(c14) 	// output  c14_sig
);

alu alu_inst
(
	.A(MDO[3:0]) ,	// input [3:0] A_sig
	.B(MDI[3:0]) ,	// input [3:0] B_sig
	.S0(c12) ,	// input  S0_sig
	.S1(c13) ,	// input  S1_sig
	.Cout(Cout) ,	// output  Cout_sig
	.ovr(ovr) ,	// output  ovr_sig
	.R(aluToBuffer) ,	// output [3:0] R_sig
	.W(holder) 	// output [13:0] W_sig
);

accumulator accumulator_inst
(
	.A(MDO[3:0]) ,	// input [3:0] A_sig
	.B(bufferToAcc) ,	// input [3:0] B_sig
	.S(c10) ,	// input  S_sig
	.load(~c11) ,	// input  load_sig
	.increment(~c9) ,	// input  increment_sig
	.clear(~c8) ,	// input  clear_sig
	.Z(MDI[3:0]) 	// output [3:0] Z_sig
);

assign accToAlu = MDI[3:0];

pInPOut pInPOut_inst
(
	.D(aluToBuffer) ,	// input [N-1:0] D_sig
	.clear(1'b1) ,	// input  clear_sig
	.load(~c14) ,	// input  load_sig
	.Q(bufferToAcc) 	// output [N-1:0] Q_sig
);

defparam pInPOut_inst.N = 4;

binaryCounter binaryCounter_inst
(
	.D(MDO[3:0]) ,	// input [N-1:0] D_sig
	.clear(~c0) ,	// input  clear_sig
	.increment(~c2) ,	// input  increment_sig
	.load(~c1) ,	// input  load_sig
	.Q(addressBus) 	// output [N-1:0] Q_sig
);

defparam binaryCounter_inst.N = 4;



binary2seven(addressBus[3], addressBus[2], addressBus[1], addressBus[0], PChex[0], PChex[1], PChex[2], PChex[3], PChex[4], PChex[5], PChex[6]);
binary2seven(MDI[3], MDI[2], MDI[1], MDI[0], MDin[0], MDin[1], MDin[2], MDin[3], MDin[4], MDin[5], MDin[6]);
//binary2seven(MDI[7], MDI[6], MDI[5], MDI[4], MDin[7], MDin[8], MDin[9], MDin[10], MDin[11], MDin[12], MDin[13]);
binary2seven(bufferToAcc[3], bufferToAcc[2], bufferToAcc[1], bufferToAcc[0], MDin[7], MDin[8], MDin[9], MDin[10], MDin[11], MDin[12], MDin[13]);
binary2seven(MDO[7], MDO[6], MDO[5], MDO[4], MDout[7], MDout[8], MDout[9], MDout[10], MDout[11], MDout[12], MDout[13]);
binary2seven(MDO[3], MDO[2], MDO[1], MDO[0], MDout[0], MDout[1], MDout[2], MDout[3], MDout[4], MDout[5], MDout[6]);
binary2seven(AddIn[3],AddIn[2], AddIn[1], AddIn[0], MARhex[0], MARhex[1], MARhex[2], MARhex[3], MARhex[4], MARhex[5], MARhex[6]);

endmodule
