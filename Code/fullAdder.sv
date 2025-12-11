module FAbehavSV (Sum, Cout, A, B, Cin);
input A, B, Cin;
output logic Sum, Cout;
always_comb
{Cout,Sum} = A + B + Cin;
endmodule
