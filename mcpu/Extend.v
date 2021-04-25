`timescale 1ns / 1ps
 
module Extend(input [15:0] in_num,
              output reg [31:0] out);
				  
    always @(in_num) 
	 begin
        out <= {{16{in_num[15]}}, in_num[15:0]}; // 符号扩充立即数，如lw、sw、beq指令
    end
 
endmodule