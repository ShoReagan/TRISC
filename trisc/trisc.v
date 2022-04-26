module trisc(
	input Mode, ClockIn, ClearAddGen, RW, //Mode = SW9, ClockIn = Key2, ClearAddGen = Key3, RW = Key5
	input [7:0]    DataIn,					  //DataIn = {SW7,SW6,SW5,SW4,SW3,SW2,SW1,SW0}
	input startStop, clock,
	output[6:0] PChex, MARhex,
	output[13:0] MDout, MDin,
	output c0, c1, c2, c3, c4, c5, c7, c8, c9, c10, c11, c12, c13, c14
);
wire[7:0] MDI, MDO;
wire[3:0] addressBus;
wire C0, C1, C2, C3, C4, C5, C7, C8, C9, C10, C11, C12, C13, C14;
wire[3:0] irToCu;
wire Cout, ovr;
wire[3:0] aluToAcc;
wire[3:0] accToAlu;
wire[3:0] bufferToAcc;
wire[3:0] ramAddress;

pInPOut IR (MDO[7:4], 1, C7, irToCu[3:0]);
controllerTester(MDO[7], MDO[6], MDO[5], MDO[4], clock, startStop, C0, C1, C2, C3, C4, C5, C7, C8, C9, C10, C11, C12, C13, C14);
alu(accToAlu[3:0], MDO[3:0], Cout, ovr, aluToAcc[3:0], MDout[13:0]);  
pInPOut buffer (accToAlu[3:0], 1, C14, bufferToAcc[3:0]);
accumulator(MDO[3:0], bufferToAcc[3:0], C10, C11, C9, C8, MDI[3:0]);
binaryCounter(MDO[7:4], C0, C2, C1, addressBus[3:0]);
assign ramAddress = C3 == 1 ? addressBus : MDO[7:4];
 
  
wire [3:0]      AddIn, AddGen; 
wire RAMin, RAMwrite, toggle; 
wire [7:0]      RAMdata; 
  
assign AddIn = Mode == 1'b0 ? ramAddress : AddGen; 
assign RAMin = Mode == 1'b0 ? clock*C4 : ClockIn; 
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






endmodule
