module RBShifter(
    input  [7:0] in,
    input  [2:0] control,
    output [7:0] out
);

logic [7:0] X, Y;

assign X = control[0] ? {1'b0, in[7:1]} : in;

assign Y = control[1] ? {2'b00, X[7:2]} : X;

assign out = control[2] ? {4'b0000, Y[7:4]} : Y;

endmodule
