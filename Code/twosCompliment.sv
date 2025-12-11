module twosCompliment #(parameter N = 8)
(
input [N-1:0] A,
 //declare input ports
output [N-1:0] B, //declare output ports for sum
output Cout
); 
logic [N:0] C; //declare internal carries
assign Cout = C[N]; //rename carry out port
assign C[0] = 1;

genvar i;
generate
for (i = 0; i < N; i++) begin : stage
halfadder halfadder_inst
(
	.s(B[i]) ,	// output  s_sig
	.cout(C[i+1]) ,	// output  cout_sig
	.a(~A[i]) ,	// input  a_sig
	.b(C[i]) 	// input  b_sig
);
end 
endgenerate
endmodule
