/*
`include "ALU.v"
`include "DataLate.v"
`include "DataMemory.v"
`include "DataSelect_2.v"
`include "Extend.v"
`include "InsMemory.v"
`include "PC.v"
`include "PCAddr.v"
`include "RegFile.v"
`include "ControlUnit.v"
*/
`timescale 1ns / 1ps
 
module mcpu(input clk, Reset,
           output wire [2:0] state_out,
           output wire [5:0] opcode,
			  output wire [4:0] rs, rt, rd,
			  output wire zero,
           output wire [31:0] ins, ReadData1, ReadData2, pc0, result);
			  
	 assign opcode = ins[31:26];
	 assign rs = ins[25:21];
	 assign rt = ins[20:16];
	 assign rd = ins[15:11];
 
    // 数据通路
    wire [31:0] j_addr, out1, out2, result1, i_IR, extendData, LateOut1, LateOut2, DataOut;
    
	 
    // 控制信号
    wire [2:0] ALUOp;
    wire [1:0] PCSrc;
    wire RegOut, PCWre, IRWre, InsMemRW, WrRegData, RegWre, ALUSrcB, DataMemRW, ALUM2Reg;
 
	 PC pc(	.clk(clk), 
				.Reset(Reset), 
				.PCWre(PCWre), 
				.PCSrc(PCSrc), 
				.imm(extendData), 
				.addr(j_addr), 
				.RDout1(ReadData1), 
				.Address(pc0)  );
 
	 InsMemory insmemory(	.addr_ins(pc0), 
									.InsMemRW(InsMemRW), 
									.IRWre(IRWre), 
									.clk(clk), 
									.ins(ins) );
	
	 PCAddr pcaddr(.in_addr(ins[25:0]), 
						.PC0(pc0), 
						.addr(j_addr) );
	 
	 RegFile regfile(.rs(ins[25:21]), 
						  .rt(ins[20:16]), 
						  .rd(ins[15:11]), 
						  .clk(clk), 
						  .RegWre(RegWre), 
						  .WrRegData(WrRegData), 
						  .RegOut(RegOut), 
						  .PC4((pc0+4)), 
						  .memData(LateOut2), 
						  .data1(ReadData1), 
						  .data2(ReadData2)  );
	
    DataLate ADR(.i_data(ReadData1), 
					  .clk(clk), 
					  .o_data(out1) );
	 DataLate BDR(.i_data(ReadData2), 
					  .clk(clk), 
					  .o_data(out2) );
	
	 Extend extend(.in_num(ins[15:0]), 
						.out(extendData) );
	 
    ALU alu(.ReadData1(out1), 
				.ReadData2(out2), 
				.inExt(extendData), 
				.ALUSrcB(ALUSrcB), 
				.ALUOp(ALUOp), 
				.zero(zero), 
				.result(result) );
	 
	 DataLate ALUout(.i_data(result), 
						  .clk(clk), 
						  .o_data(result1) );
	 
	 DataMemory datamemory(.addr_data(result1), 
								  .Data2(out2), 
								  .DataMemRW(DataMemRW), 
								  .DataOut(DataOut) );
	 
	 DataSelect_2 dataselect_2(.A(result), 
										.B(DataOut), 
										.Sign(ALUM2Reg), 
										.Get(LateOut1) );
	
	 DataLate ALUM2DR(.i_data(LateOut1), 
							.clk(clk), 
							.o_data(LateOut2) );
	 
	 controlUnit control(.opcode(ins[31:26]), 
								.zero(zero), 
								.clk(clk), 
								.Reset(Reset),
								.RegOut(RegOut),
								.PCWre(PCWre), 
								.InsMemRW(InsMemRW), 
								.IRWre(IRWre), 
								.WrRegData(WrRegData), 
								.RegWre(RegWre), 
								.ALUSrcB(ALUSrcB), 
								.ALUM2Reg(ALUM2Reg), 
								.DataMemRW(DataMemRW), 
								.PCSrc(PCSrc), 
								.ALUOp(ALUOp), 
								.state_out(state_out) );
	
 
endmodule