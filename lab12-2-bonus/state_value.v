`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:02:35 09/02/2015 
// Design Name: 
// Module Name:    state_value 
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
module state_value(value_0,value_1,value_2,value_3,value_4,value_5,lap_0,lap_1,lap_2,lap_3,lap_4,lap_5,real_0,real_1,real_2,real_3,clk,rst_n,switch,state_start,state_lap,switch_set,switch_count
    );
	input [3:0] value_0,value_1,value_2,value_3,value_4,value_5;
	input [3:0] lap_0,lap_1,lap_2,lap_3,lap_4,lap_5;
	input clk,rst_n;
	input switch;
	output [3:0] real_0,real_1,real_2,real_3;
	reg [3:0] real_0,real_1,real_2,real_3;
	reg [3:0] temp0,temp1,temp2,temp3;
	input state_start;
	input state_lap;
	input switch_set;
	input switch_count;
	
	always@(*)
	
	if(state_lap==1'b1 && state_start==1'b1 && switch_set==1'b1 && switch_count==1'b0)
		if(switch==1'b0)
			begin
				temp0=lap_0;
				temp1=lap_1;
				temp2=lap_2;
				temp3=lap_3;
			end
		else
			begin
				temp0=lap_4;
				temp1=lap_5;
				temp2=4'b0000;
				temp3=4'b0000;
			end
	else if(switch_count==1'b1)
		begin
			temp0=value_4;
			temp1=value_5;
			temp2=value_0;
			temp3=value_1;
		end
	else
		if(switch==1'b0)
			begin
				temp0=value_0;
				temp1=value_1;
				temp2=value_2;
				temp3=value_3;
			end
		else
			begin
				temp0=value_4;
				temp1=value_5;
				temp2=4'b0000;
				temp3=4'b0000;
			end
	
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				real_0<=4'b0000;
				real_1<=4'b0000;
				real_2<=4'b0000;
				real_3<=4'b0000;
			end
		else
			begin
				real_0<=temp0;
				real_1<=temp1;
				real_2<=temp2;
				real_3<=temp3;
			end
		
		
endmodule
