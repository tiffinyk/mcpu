`timescale 1ns / 1ps

module ALU(input [31:0] ReadData1, ReadData2, inExt,
           input ALUSrcB,
			  input [2:0] ALUOp,
			  output wire zero,
			  output reg [31:0] result);
	 
	 initial begin
        result = 0;
    end
 
    wire [31:0] B;
	 assign B = ALUSrcB? inExt : ReadData2;
	 assign zero = (result? 0 : 1);
	 
	 always @(ReadData1 or ReadData2 or B or ALUOp) begin
        case(ALUOp)
            3'b000: result = ReadData1 + B;  // A + B
            3'b001: result = ReadData1 - B;  // A - B
				3'b010: result = ReadData1 & B; // 与
				3'b011: result = ReadData1 | B; // 或
				3'b100: result = ~(ReadData1 | B); // 或非
            3'b101: result = (ReadData1 < B ? 1 : 0);  // 比较A与B
        default: result = 0;
    endcase
  end
	 
endmodule