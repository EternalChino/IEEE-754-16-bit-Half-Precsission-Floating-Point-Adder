module exponentSubtractor  #(parameter N = 5)
(
input [N-1:0] A,B,
output [N-1:0] Result, 
output Cout
);

logic [N-1:0] R, X;
logic select;
assign Cout = select;
assign  Result = select ? R : X;


RCAddSub #(.N(N)) RCAddSub_inst
(
	.A(A) ,	// input [(N-1):0] A_sig
	.B(B) ,	// input [(N-1):0] B_sig
	.S(R) ,	// output [(N-1):0] S_sig
	.Cout(select) 	// output  Cout_sig
);



twosCompliment #(.N(N)) twosCompliment_inst
(
	.A(R) ,	// input [(N-1):0] A_sig
	.B(X) ,	// output [(N-1):0] B_sig
	.Cout(Cout_sig) 	// output  Cout_sig
);



endmodule