module floatAdder
(
    input  [15:0] A,
    input  [15:0] B,
    output [15:0] R
);

logic signA, signB;
logic [4:0] expA, expB;
logic [9:0] mantissaARaw, mantissaBRaw;

assign signA = A[15];
assign expA = A[14:10];
assign mantissaARaw = A[9:0];

assign signB = B[15];
assign expB = B[14:10];
assign mantissaBRaw = B[9:0];

logic [10:0] mantissaA, mantissaB;

assign mantissaA = {1'b1, mantissaARaw};
assign mantissaB = {1'b1, mantissaBRaw};

logic [4:0] expDiff;
logic expSign;

exponentSubtractor #(.N(5)) expSubtractor (
    .A(expA),
    .B(expB),
    .Result(expDiff),
    .Cout(expSign)
);

logic [10:0] mantissaShiftIn;

assign mantissaShiftIn = (expSign) ? mantissaB : mantissaA;

logic [10:0] mantissaShifted;

MantissaRightShifter #(.N(11)) mantissaRightShifter (
    .in(mantissaShiftIn),
    .shift(expDiff[3:0]),
    .out(mantissaShifted)
);

logic [10:0] mantissaBig, mantissaSmall;

assign mantissaBig = (expSign) ? mantissaA : mantissaB;
assign mantissaSmall = mantissaShifted;

logic [11:0] mantissaSum;
logic carryOut;

CLAPARAMETER #(.N(11)) mantissaAdder (
    .A(mantissaBig),
    .B(mantissaSmall),
    .opCode(1'b0),
    .R(mantissaSum[10:0]),
    .Cout(carryOut)
);

assign mantissaSum[11] = carryOut;

logic [9:0] mantissaNorm;
//logic expInc;
wire expUp, expDown;

MantissaNormalizer #(.N(12)) mantissaNormalizer (
    .inputBits(mantissaSum),
    .normalizedMantissa(mantissaNorm),
    .exponentIncrease(expUp),
    .exponentDecrease(expDown)
);


logic [4:0] expBig;

assign expBig = (expSign) ? expA : expB;

logic [4:0] expOut;

incrementerAndDecrementer #(.N(5)) expAdjust (
    .inputValue(expBig),
    .operationSelect(expDown),
    .carryIn(expUp),
    .resultValue(expOut),
    .carryOut()
);


logic signOut;
assign signOut = signA;

assign R = { signOut, expOut, mantissaNorm };

endmodule
