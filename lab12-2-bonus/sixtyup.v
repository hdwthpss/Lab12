`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:03:54 08/29/2015 
// Design Name: 
// Module Name:    sixtyup 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`define BCD_BIT_WIDTH 4
`define DISABLED 1
`define ENABLED 1
`define BCD_NINE 4
`define BCD_ZERO 4
`define BCD_FIVE 4
`define BCD_THREE 4
`define INCREMENT 4 
`define BCD_TWO 4
`define BCD_ONE 4

module sixtyup(clk,rst_n,sec1,sec0,sec2,sec3,sec4,sec5//,sec0_mode,sec1_mode,sec2_mode,sec3_mode,sec4_mode,sec5_mode
    );
	 
	input clk;
	input rst_n;
	
	
	
	output [`BCD_BIT_WIDTH-1:0] sec0;
	output [`BCD_BIT_WIDTH-1:0] sec1;
	output [`BCD_BIT_WIDTH-1:0] sec2;
	output [`BCD_BIT_WIDTH-1:0] sec3;
	output [`BCD_BIT_WIDTH-1:0] sec4;
	output [`BCD_BIT_WIDTH-1:0] sec5;
	
	
	
	reg load_def_sec;
	
	
	wire cout_sec0,cout_sec1,cout_sec2,cout_sec3,cout_sec4;
	
	
	
	always@(*)
	
		if((sec1==`BCD_FIVE'b0101) && (sec0==`BCD_NINE'b1001) && (sec3==`BCD_FIVE'b0101) && (sec2==`BCD_NINE'b1001) && (sec4==`BCD_THREE'b0011) && (sec5==`BCD_TWO'b0010))
			load_def_sec=`ENABLED'b1;
		else
			load_def_sec=`DISABLED'b0;
	
	
	dig0 dig00(
	.value(sec0),
	.carry(cout_sec0),
	.clk(clk),
	.rst_n(rst_n),
	.increase(`ENABLED'b1),
	.load_def(load_def_sec),
	.def_value(`BCD_ZERO'b0000)
	);
	
	dig1 dig11(
	.value(sec1),
	.carry(cout_sec1),
	.clk(clk),
	.rst_n(rst_n),
	.increase(cout_sec0),
	.load_def(load_def_sec),
	.def_value(`BCD_ZERO'b0000)
	);
	
	dig2 dig22(
	.value(sec2),
	.carry(cout_sec2),
	.clk(clk),
	.rst_n(rst_n),
	.increase(cout_sec1),
	.load_def(load_def_sec),
	.def_value(`BCD_ZERO'b0000)
	);
	
	dig3 dig33(
	.value(sec3),
	.carry(cout_sec3),
	.clk(clk),
	.rst_n(rst_n),
	.increase(cout_sec2),
	.load_def(load_def_sec),
	.def_value(`BCD_ZERO'b0000)
	);
	
	dig_4 dig44(
	.value(sec4),
	.carry(cout_sec4),
	.clk(clk),
	.rst_n(rst_n),
	.increase(cout_sec3),
	.load_def(load_def_sec),
	.def_value(`BCD_ZERO'b0000)
	);
	
	dig_5 dig55(
	.value(sec5),
	.carry(cout_sec5),
	.clk(clk),
	.rst_n(rst_n),
	.increase(cout_sec4),
	.load_def(load_def_sec),
	.def_value(`BCD_ZERO'b0000)
	);
			


endmodule
