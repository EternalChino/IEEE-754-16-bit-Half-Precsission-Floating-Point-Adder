module MantissaRightShifter #(parameter N = 11)
(
    input  [N-1:0] in,
    input  [3:0]   shift,
    output [N-1:0] out
);

logic [N-1:0] s1, s2, s3, s4;
// Shift by 1
assign s1 = shift[0] ? {1'b0, in[N-1:1]} : in;
// Shift by 2
assign s2 = shift[1] ? {2'b00, s1[N-1:2]} : s1;
// Shift by 4
assign s3 = shift[2] ? {4'b0000, s2[N-1:4]} : s2;
// Shift by 8
assign s4 = shift[3] ? {8'b0, s3[N-1:8]} : s3;
assign out = s4;
endmodule