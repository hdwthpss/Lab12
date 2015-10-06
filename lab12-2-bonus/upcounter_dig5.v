`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:04:05 09/03/2015 
// Design Name: 
// Module Name:    upcounter_dig5 
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
module upcounter_dig5(decrease,clk,rst_n,load_def,def_value,value,de_carry,switch_up_down,switch_count,increase,carry
    );
	input decrease;
	input clk,rst_n;
	input load_def;
	input [3:0] def_value;
	output [3:0] value;
	output de_carry;
	reg de_carry;
	reg [3:0] value;
	reg [3:0] temp_value;
	input switch_up_down;
	input switch_count;
	
	input increase;
	output carry;
	reg carry;
	
	always@(*)
	begin
		if(switch_count==1'b1)
			if(increase==1'b0 && load_def!=1'b1)
				temp_value=value;
			else if(load_def==1'b1)
				temp_value=def_value;
			else if(increase==1'b1 && value==4'b0101)
				temp_value=4'b0000;
			else
				temp_value=value+4'b0001;
		
		if(switch_up_down==1'b1)
			if(decrease==1'b0 && load_def!=1'b1)
				temp_value=value;
			else if(load_def==1'b1)
				temp_value=def_value;
			else if(decrease==1'b1 && value==4'b0000)
				temp_value=4'b0101;
			else
				temp_value=value-4'b0001;
	end
	
	always@(*)
		begin
			if(switch_count==1'b1)
				if(value==4'b0101 && increase==1'b1)
					carry=1'b1;
				else
					carry=1'b0;
			
			if(switch_up_down==1'b1)
				if(value==4'b0000 && decrease==1'b1)
					de_carry=1'b1;
				else
					de_carry=1'b0;
		end
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			value<=def_value;
		else
			value<=temp_value;


endmodule
