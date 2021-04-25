`timescale 1ns / 1ps
 
module PCAddr(input [25:0] in_addr,
              input [31:0] PC0,
				  output reg [31:0] addr);
    wire [27:0] mid;
	 reg [31:0] PC4;
	 assign mid = in_addr << 2;
    always @(in_addr) begin
	     PC4 <= PC0+4;
        addr <= {PC4[31:28], mid[27:0]};
    end
 
endmodule