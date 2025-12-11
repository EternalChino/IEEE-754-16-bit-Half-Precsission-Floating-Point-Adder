module incrementerAndDecrementer #(parameter N = 8)
(
    input  [N-1:0] inputValue,
    input          operationSelect,
    input          carryIn,
    output [N-1:0] resultValue,
    output         carryOut
);

    wire [N:0] carryChain;
    assign carryChain[0] = carryIn;

    wire [N-1:0] operandB = operationSelect ? ~{N{1'b0}} : {N{1'b0}};

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : fullAdderSection
            FAbehavSV fullAdder (
                .A(inputValue[i]),
                .B(operandB[i]),
                .Cin(carryChain[i]),
                .Sum(resultValue[i]),
                .Cout(carryChain[i+1])
            );
        end
    endgenerate

    assign carryOut = carryChain[N];

endmodule
