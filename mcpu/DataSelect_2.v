`timescale 1ns / 1ps
 
module DataSelect_2(input [31:0] A, B,
                    input Sign,
						  output wire [31:0] Get);
 
    assign Get = Sign ? B : A;
 
endmodule