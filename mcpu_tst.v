`timescale 1ns / 1ps

module mcpu_tst();
   //inputs
	reg clk;
	reg Reset;
	
	//outputs
	wire [2:0] state_out;
   wire [5:0] opcode;
   wire [4:0] rs, rt, rd;
	wire zero;
   wire [31:0] ins, ReadData1, ReadData2, pc0, result;
	
	mcpu mcpu0(.clk(clk), 
	           .Reset(Reset),
              .state_out(state_out),
              .opcode(opcode),
			     .rs(rs), 
				  .rt(rt), 
				  .rd(rd),
				  .zero(zero),
              .ins(ins), 
				  .ReadData1(ReadData1), 
				  .ReadData2(ReadData2), 
				  .pc0(pc0), 
				  .result(result)
					);
	
	initial begin
              clk = 0;
              Reset = 0;
				  clk= ~clk;

              //Wait 100 ns for global reset to finish

              #100;

              Reset = 1;
	end

   always
   	#(100) clk = ~clk;
endmodule