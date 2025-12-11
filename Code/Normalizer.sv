module MantissaNormalizer #(parameter N = 12)
(
    input  [N-1:0] inputBits,
    output [9:0]   normalizedMantissa,
    output         exponentIncrease,
    output         exponentDecrease
);

    wire [11:0] mantissaInput = inputBits;

    assign exponentIncrease = mantissaInput[11];

    wire [3:0] leadingZeroCount;
    wire allBitsZero = (mantissaInput[10:0] == 0);

    assign leadingZeroCount =
        mantissaInput[10] ? 4'd0  :
        mantissaInput[9]  ? 4'd1  :
        mantissaInput[8]  ? 4'd2  :
        mantissaInput[7]  ? 4'd3  :
        mantissaInput[6]  ? 4'd4  :
        mantissaInput[5]  ? 4'd5  :
        mantissaInput[4]  ? 4'd6  :
        mantissaInput[3]  ? 4'd7  :
        mantissaInput[2]  ? 4'd8  :
        mantissaInput[1]  ? 4'd9  :
        mantissaInput[0]  ? 4'd10 : 4'd11;

    assign exponentDecrease =
        (!exponentIncrease && !allBitsZero) ? (leadingZeroCount != 0) : 1'b0;

    wire [10:0] mantissaShiftedRight = mantissaInput[11:1];
    wire [10:0] mantissaShiftedLeft  = mantissaInput[10:0] << leadingZeroCount;

    wire [10:0] normalizedMantissaFull =
        exponentIncrease ? mantissaShiftedRight :
        exponentDecrease ? mantissaShiftedLeft  :
                           mantissaInput[10:0];

    assign normalizedMantissa = normalizedMantissaFull[9:0];

endmodule
