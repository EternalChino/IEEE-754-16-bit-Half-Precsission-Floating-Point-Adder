module toplevel #(parameter N=4)
(
input  logic Clock, Reset, KEY2, KEY3, KEY4,
input  logic [3:0] Row,
output logic [3:0] Col, Value,
output logic [N-1:0] CAT,
output logic [6:0] SEG
);

logic Trig;
logic [(N*4)-1:0] Out;
logic [N-1:0] HEX0, HEX1, HEX2, HEX3;
logic [15:0] A, B, Result, displayValue;
logic [1:0] mode;

keypad_input keypad_input_inst
(
    .clk(Clock),
    .reset(Reset),
    .row(Row),
    .col(Col),
    .out(Out),
    .value(Value),
    .trig(Trig)
);

floatAdder floatAdder_inst
(
    .A(A),      // input [15:0] A_sig
    .B(B),      // input [15:0] B_sig
    .R(Result)  // output [15:0] R_sig
);

always_ff @(posedge Clock or negedge Reset) begin
    if (~Reset) begin
        A <= 16'h0000;
        B <= 16'h0000;
        mode <= 0;
    end else begin
        if (~KEY2) begin
            A <= Out;         // Store keypad value in A when KEY2 is pressed
            mode <= 1;        // Set mode to display A
        end else if (~KEY3) begin
            B <= Out;         // Store keypad value in B when KEY3 is pressed
            mode <= 2;        // Set mode to display B
        end else if (~KEY4) begin
            mode <= 3;        // Set mode to display result R when KEY4 is pressed
        end
    end
end

always_comb begin
    case (mode)
        1: displayValue = A;   // Display A when KEY2 is pressed
        2: displayValue = B;   // Display B when KEY3 is pressed
        3: displayValue = Result;   // Display result R when KEY4 is pressed
        default: displayValue = Out; // Display keypad input by default
    endcase
end

assign {HEX3, HEX2, HEX1, HEX0} = displayValue;

controller partA_inst
(
    .MuxRate(Clock),
    .Reset(Reset),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .CAT(CAT),
    .SEG(SEG)
);

endmodule
