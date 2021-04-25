`timescale 1ns / 1ps
 
module DataMemory(input [31:0] addr_data, Data2,
                  input DataMemRW,
		  output reg [31:0] DataOut);
					  
	 reg [7:0] memory [0:63];
	 integer i;
	 /*initial begin
	     for (i = 0; i < 64; i = i+1) memory[i] <= 0;
	 end
	 */
	 initial begin
	     $readmemb("C:/Users/ASUS/Desktop/mcpu_2/my_data.txt", memory);
	 end
	 
    always @(addr_data or Data2 or DataMemRW) begin
      if (DataMemRW) begin // write data
          memory[addr_data] = Data2[31:24];
          memory[addr_data+1] = Data2[23:16];
          memory[addr_data+2] = Data2[15:8];
          memory[addr_data+3] = Data2[7:0];
      end 
		else begin // read data
          DataOut[31:24] = memory[addr_data];
          DataOut[23:16] = memory[addr_data+1];
          DataOut[15:8] = memory[addr_data+2];
          DataOut[7:0] = memory[addr_data+3];
      end
    end
 
endmodule