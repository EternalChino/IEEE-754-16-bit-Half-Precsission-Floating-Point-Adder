//Ripple Carry Adder Subtractor Structural Model
module RCAddSub #(parameter N = 8)
(
input [N-1:0] A, B,
 //declare input ports
output [N-1:0] S, //declare output ports for sum
output Cout
); 
logic [N:0] C; //declare internal carries
assign Cout = C[N]; //rename carry out port
assign C[0] = 1;

genvar i;
generate
for (i = 0; i < N; i++) 
begin : stage
FAbehavSV fa (
.A(A[i]),
.B(B[i]^1), 
.Cin(C[i]),
.Sum(S[i]),
.Cout(C[i+1])
);
end 
endgenerate
endmodule