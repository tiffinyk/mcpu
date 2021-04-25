`timescale 1ns / 1ps
 
module InsMemory(input [31:0] addr_ins,
                 input InsMemRW, IRWre, clk,
					  output reg [31:0] ins);
					  
    reg [31:0] ins_out;
	 reg [7:0] mem [0:127];
	 
	 initial begin
	     $readmemb("C:/Users/ASUS/Desktop/mcpu_2/my_ins.txt", mem);
		  //ins_out = 0;
	 end
 
    always @( addr_ins or InsMemRW) begin
        if (InsMemRW) begin
          ins_out[31:24] = mem[addr_ins];
          ins_out[23:16] = mem[addr_ins+1];
          ins_out[15:8] = mem[addr_ins+2];
          ins_out[7:0] = mem[addr_ins+3];
        end
	 end
	 
	 always @(posedge clk) begin
	     if (IRWre) ins <= ins_out;
	 end
 
endmodule