module Mux5bits (
    input [4:0] A, B,
    input s,
    output [4:0] r
);

assign r = s ? A : B;
    
endmodule