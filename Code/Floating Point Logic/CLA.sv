// code given by Dr. Carrol in 9.1

module CLAPARAMETER #(parameter N = 11)
(
    input  [N-1:0] A,
    input  [N-1:0] B,
    input          opCode,     
    output [N-1:0] R,
    output         Cout
);

    wire [N:0]   C;
    wire [N-1:0] G, P, SUM;

    assign C[0] = opCode;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : CLA_FA
            FAbehavSV fa_inst (
                .A(A[i]),
                .B(B[i] ^ opCode),
                .Cin(C[i]),
                .Sum(SUM[i]),
                .Cout()
            );
        end
    endgenerate

    genvar j;
    generate
        for (j = 0; j < N; j = j + 1) begin : CLA_CHAIN
            assign G[j] = A[j] & (B[j] ^ opCode);
            assign P[j] = A[j] ^ (B[j] ^ opCode);   
            assign C[j+1] = G[j] | (P[j] & C[j]);
        end
    endgenerate

    assign R    = SUM;
    assign Cout = C[N];
endmodule
