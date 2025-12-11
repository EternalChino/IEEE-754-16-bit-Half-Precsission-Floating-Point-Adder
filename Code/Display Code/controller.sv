module controller #(parameter N=4)
(
input MuxRate, Reset,Load,
input logic [N-1:0] HEX0,HEX1,HEX2,HEX3,
output logic [N-1:0] CAT,
output logic [6:0] SEG
);

logic [N-1:0] Q0,Q1,Q2,Q3, Y;
logic [31:0] clockLadder;
logic [1:0] SEL;



four2one four2one_inst
(
	.A(SEL[0]) ,	// input  A_sig
	.B(SEL[1]) ,	// input  B_sig
	.D0(HEX0) ,	// input [(N-1):0] D0_sig
	.D1(HEX1) ,	// input [(N-1):0] D1_sig
	.D2(HEX2) ,	// input [(N-1):0] D2_sig
	.D3(HEX3) ,	// input [(N-1):0] D3_sig
	.Y(Y) 	// output [(N-1):0] Y_sig
);
NbitRegisterSV NbitRegisterSV_inst
(
	.D({HEX0,HEX1,HEX2,HEX3}) ,	// input [(N-1):0] D_sig
	.CLK(Load) ,	// input  CLK_sig
	.CLR(Reset) ,	// input  CLR_sig
	.Q({Q0,Q1,Q2,Q3}) 	// output [(N-1):0] Q_sig
);

hex2seven hex2seven_inst
(
	.w(Y[3]) ,	// input  w_sig
	.x(Y[2]) ,	// input  x_sig
	.y(Y[1]) ,	// input  y_sig
	.z(Y[0]) ,	// input  z_sig
	.a(SEG[0]) ,	// output  a_sig
	.b(SEG[1]) ,	// output  b_sig
	.c(SEG[2]) ,	// output  c_sig
	.d(SEG[3]) ,	// output  d_sig
	.e(SEG[4]) ,	// output  e_sig
	.f(SEG[5]) ,	// output  f_sig
	.g(SEG[6]) 	// output  g_sig
);

ClockLadder ClockLadder_inst
(
	.clock(MuxRate) ,	// input  clock_sig
	.clear(Reset) ,	// input  clear_sig
	.Y(clockLadder) 	// output [(N-1):0] Y_sig
);

FSM FSM_inst
(
	.clock(clockLadder[17]) ,	// input  clock_sig
	.reset(Reset) ,	// input  reset_sig
	.SEL(SEL) ,	// output [1:0] SEL_sig
	.CAT(CAT) 	// output [(N-1):0] CAT_sig
);

endmodule
