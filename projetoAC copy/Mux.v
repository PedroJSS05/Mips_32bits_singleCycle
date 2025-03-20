module Mux (
    input A, B,
    input s,
    output r
);

assign r = s ? A : B;
    
endmodule