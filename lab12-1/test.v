`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:24:37 08/29/2015 
// Design Name: 
// Module Name:    test 
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
`define INCREMENT 4 

module test(clk,rst_n,wh_light,display,switch,switch_mode,in0,in1,in2,in3
    );
	 
	input clk;
	input rst_n;
	input switch;
	input switch_mode;
	wire clk_out;
	wire [1:0] clk_ctl;
	
	output [3:0] wh_light;
	
	wire [3:0] bcd;
	output [14:0] display;
	wire [6:0] cnt_h;
	
	wire [`BCD_BIT_WIDTH-1:0] sec1;
	wire [`BCD_BIT_WIDTH-1:0] sec0;
	wire [`BCD_BIT_WIDTH-1:0] sec2;
	wire [`BCD_BIT_WIDTH-1:0] sec3;
	wire [`BCD_BIT_WIDTH-1:0] sec4;
	wire [`BCD_BIT_WIDTH-1:0] sec5;
	
	/*wire [`BCD_BIT_WIDTH-1:0] sec1_mode;
	wire [`BCD_BIT_WIDTH-1:0] sec0_mode;
	wire [`BCD_BIT_WIDTH-1:0] sec2_mode;
	wire [`BCD_BIT_WIDTH-1:0] sec3_mode;
	wire [`BCD_BIT_WIDTH-1:0] sec4_mode;
	wire [`BCD_BIT_WIDTH-1:0] sec5_mode;*/
	
	
	output  [`BCD_BIT_WIDTH-1:0] in0,in1,in2,in3; 
	
	freq_div f(
	.clk(clk),
	.rst_n(rst_n),
	.clk_ctl(clk_ctl),
	.clk_out(clk_out),
	.cnt_h(cnt_h)
	);
	
	scan s(
	.freq_ctl(clk_ctl),
	.in0(in0),
	.in1(in1),
	.in2(in2),
	.in3(in3),
	.wh_light(wh_light),
	.light_num(bcd)
	);
	
	bcd_seg b(
	.bcd(bcd),
	.display(display)
	);
	
	sixtyup st(
	.sec1(sec1),
	.sec0(sec0),
	.sec2(sec2),
	.sec3(sec3),
	.sec4(sec4),
	.sec5(sec5),
	/*.sec0_mode(sec0_mode),
	.sec1_mode(sec1_mode),
	.sec2_mode(sec2_mode),
	.sec3_mode(sec3_mode),
	.sec4_mode(sec4_mode),
	.sec5_mode(sec5_mode),*/
	.clk(clk_out),
	.rst_n(rst_n)
	);
	
	/*
	sixtyup_mode stm(
	.sec1(sec1_mode),
	.sec0(sec0_mode),
	.sec2(sec2_mode),
	.sec3(sec3_mode),
	.sec4(sec4_mode),
	.sec5(sec5_mode),
	.clk(clk_ctl[0]),
	.rst_n(rst_n)
	);*/
	
	
	switch_h_m_s sw(
	.switch(switch),
	.switch_mode(switch_mode),
	.sec1(sec1),
	.sec0(sec0),
	.sec2(sec2),
	.sec3(sec3),
	.sec4(sec4),
	.sec5(sec5),
	/*.sec0_mode(sec0_mode),
	.sec1_mode(sec1_mode),
	.sec2_mode(sec2_mode),
	.sec3_mode(sec3_mode),
	.sec4_mode(sec4_mode),
	.sec5_mode(sec5_mode),*/
	.in0(in0),
	.in1(in1),
	.in2(in2),
	.in3(in3)
	);

	

endmodule
