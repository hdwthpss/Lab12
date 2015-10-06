`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:33:54 08/21/2015 
// Design Name: 
// Module Name:    freq_div 
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
	`define FREQ_DIV_BIT 25
module freq_div(clk,rst_n,clk_out,clk_ctl,cnt_h,cnt_l
    );
	input clk;
	input rst_n;
	output clk_out;
	output [1:0] clk_ctl;
	reg clk_out;
	reg [1:0] clk_ctl;
	output reg [14:0] cnt_l;
	output reg [6:0] cnt_h;
	reg [`FREQ_DIV_BIT-1:0] cnt_temp;
	
	always@(clk_ctl or clk_out or cnt_l or cnt_h)
		cnt_temp={clk_out,cnt_h,clk_ctl,cnt_l}+1'b1;
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			{clk_out,cnt_h,clk_ctl,cnt_l}=`FREQ_DIV_BIT'd0;
		else
			{clk_out,cnt_h,clk_ctl,cnt_l}=cnt_temp;
	
	
	
endmodule