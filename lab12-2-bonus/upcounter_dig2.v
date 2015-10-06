`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:03:16 09/02/2015 
// Design Name: 
// Module Name:    upcounter_dig2 
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
module upcounter_dig2(increase,clk,rst_n,value,carry,load_def,def_value,decrease,de_carry,switch_up_down,switch_count
    );
	input increase;
	input clk,rst_n;
	input load_def;
	input [3:0] def_value;
	output [3:0] value;
	output carry;
	reg carry;
	reg [3:0] value;
	reg [3:0] temp_value;
	
	input switch_count;
	input switch_up_down;
	input decrease;
	output de_carry;
	reg de_carry;
	
	always@(*)
	if(switch_up_down==1'b0 && switch_count!=1'b1)
		if(increase==1'b0 && load_def!=1'b1)
			temp_value=value;
		else if(load_def==1'b1)
			temp_value=def_value;
		else if(increase==1'b1 && value==4'b1001)
			temp_value=4'b0000;
		else
			temp_value=value+4'b0001;
	else
		if(decrease==1'b0)
			temp_value=value;
		else if(load_def==1'b1)
			temp_value=def_value;
		else if(decrease==1'b1 && value==4'b0000)
			temp_value=4'b1001;
		else
			temp_value=value-4'b0001;
			
	always@(*)
	if(switch_up_down==1'b0)
		if(value==4'b1001 && increase==1'b1)
			carry=1'b1;
		else
			carry=1'b0;
	else
		if(value==4'b1001 && decrease==1'b1)
			de_carry=1'b1;
		else
			de_carry=1'b0;
			
			
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			value<=def_value;
		else
			value<=temp_value;
	

endmodule

