`timescale 1ns / 1ps
 
module RegFile(input [4:0] rs, rt, rd,
               input clk, RegWre, WrRegData,
		      	input RegOut,
			  	   input [31:0] PC4, memData,
			 	   output reg [31:0] data1, data2);
 
    reg [31:0] i_data;
	 
	 
	 reg [4:0] temp;
	 
	 reg [31:0] register [0:31];
	 integer i;
    initial begin
        for (i = 0 ; i < 32; i = i+1) 
		      register[i] = 0;
    end
    
    always @(negedge clk) begin
	     case(RegOut)
	         1'b0: temp = rt;
		      1'b1: temp = rd;
		  endcase
		  i_data <= WrRegData? memData : PC4;
		  data1 <= register[rs];
        data2 <= register[rt];
        if (RegWre == 1) begin 
            register[temp] <= i_data;
        end
    end
	 
 
endmodule