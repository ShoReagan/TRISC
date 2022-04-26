module ram(input Mode, ClockIn, ClearAddGen, RW,  //Mode = SW9, ClockIn = Key2, ClearAddGen = Key3, RW = Key5 
input [7:0]    DataIn);    //DataIn = {SW7,SW6,SW5,SW4,SW3,SW2,SW1,SW0} 

wire [3:0] AddIn, AddGen; 
wire RAMin, RAMwrite, toggle;
wire [7:0] RAMdata;
  
assign AddIn = Mode == 1'b0 ? RAMadd : AddGen; 
assign RAMin = Mode == 1'b0 ? SysClock*c4 : ClockIn; 
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
