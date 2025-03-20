module controlUnit (
    input [5:0] Opcode,
    input [5:0] Funct,
    input zero,
    output reg MemtoReg,
    output reg MemWrite,
    output reg Branch,
    output reg [3:0] ALUcontrol,
    output reg ALUSrc,
    output reg RegDst,
    output reg RegWrite,
    output reg jump,
    output PCSrc
);

assign PCSrc = zero & Branch;

reg [1:0] ALUop;

    always @(*) begin
        case (Opcode)
            6'b000000:begin
                RegWrite = 1;
                RegDst = 1;
                ALUSrc = 0;
                Branch = 0;
                MemWrite = 0;
                MemtoReg = 0;
                ALUop = 2'b10;
                jump = 0;
            end
            6'b100011:begin
                RegWrite = 1;
                RegDst = 0;
                ALUSrc = 1;
                Branch = 0;
                MemWrite = 0;
                MemtoReg = 1;
                ALUop = 2'b00;
                jump = 0;
            end
            6'b101011:begin
                RegWrite = 0;
                RegDst = 0; // DC
                ALUSrc = 1;
                Branch = 0;
                MemWrite = 1;
                MemtoReg = 1; // DC
                ALUop = 2'b00;
                jump = 0;
            end
            6'b000100:begin
                RegWrite = 0;
                RegDst = 0;  // DC
                ALUSrc = 0;
                Branch = 1;
                MemWrite = 0;
                MemtoReg = 1; // DC
                ALUop = 2'b01;
                jump = 0;
            end
            6'b001000:begin
                RegWrite = 1;
                RegDst = 0;
                ALUSrc = 1;
                Branch = 0;
                MemWrite = 0;
                MemtoReg = 0;
                ALUop = 2'b00;
                jump = 0;
            end
            6'b000010:begin
                RegWrite = 0;
                RegDst = 0;
                ALUSrc = 0;
                Branch = 0;
                MemWrite = 0;
                MemtoReg = 0;
                ALUop = 2'b00;
                jump = 1;
            end
        endcase
    end

always @(*) begin
    case (ALUop)
        2'b00: assign ALUcontrol = 4'b0010;
        2'b01: assign ALUcontrol = 4'b0110;
        2'b10: case (Funct)
            6'b100000: assign ALUcontrol = 4'b0010;
            6'b100010: assign ALUcontrol = 4'b0110;
            6'b100100: assign ALUcontrol = 4'b0000;
            6'b100101: assign ALUcontrol = 4'b0001;
            6'b101010: assign ALUcontrol = 4'b0111;
        endcase
    endcase
end

endmodule