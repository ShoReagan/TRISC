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
wire C0, C1, C2, C3, C4, C5, C7, C8, C9, C10, C11, C12, C13, C14;
wire[3:0] ramAddress;

  
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

binary2seven(MDO[7], MDO[6], MDO[5], MDO[4], MDout[7], MDout[8], MDout[9], MDout[10], MDout[11], MDout[12], MDout[13]);
binary2seven(MDO[3], MDO[2], MDO[1], MDO[0], MDout[0], MDout[1], MDout[2], MDout[3], MDout[4], MDout[5], MDout[6]);
binary2seven(AddIn[3], AddIn[2], AddIn[1], AddIn[0], PChex[0], PChex[1], PChex[2], PChex[3], PChex[4], PChex[5], PChex[6]);


endmodule
