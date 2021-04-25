`timescale 1ns / 1ps
 
module DataLate(input [31:0] i_data,
                input clk,
                output reg [31:0] o_data);
 
    always @(negedge clk) begin
        o_data = i_data;
    end
 
endmodule