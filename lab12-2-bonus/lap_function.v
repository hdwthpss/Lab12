`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:43 09/02/2015 
// Design Name: 
// Module Name:    lap_function 
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
module lap_function(one_pulse_state_lap,value_0,value_1,value_2,value_3,value_4,value_5,lap_0,lap_1,lap_2,lap_3,lap_4,lap_5,clk,rst_n,state_start,switch_set
    );
	input switch_set;
	input one_pulse_state_lap;
	input state_start;
	input clk,rst_n;
	input [3:0] value_0,value_1,value_2,value_3,value_4,value_5;
	output [3:0] lap_0,lap_1,lap_2,lap_3,lap_4,lap_5;
	reg [3:0] lap_0,lap_1,lap_2,lap_3,lap_4,lap_5;
	reg [3:0] temp_value_0,temp_value_1,temp_value_2,temp_value_3,temp_value_4,temp_value_5;


	always@(*)
	if(switch_set==1'b1)
		if(one_pulse_state_lap==1'b1 && state_start==1'b1)
			begin
				temp_value_0=value_0;
				temp_value_1=value_1;
				temp_value_2=value_2;
				temp_value_3=value_3;
				temp_value_4=value_4;
				temp_value_5=value_5;
			end
		else
			begin
				temp_value_0=lap_0;
				temp_value_1=lap_1;
				temp_value_2=lap_2;
				temp_value_3=lap_3;
				temp_value_4=lap_4;
				temp_value_5=lap_5;
				
			end
	
	always@(posedge clk or negedge rst_n)
		if(~rst_n)
			begin
				lap_0<=4'b0000;
				lap_1<=4'b0000;
				lap_2<=4'b0000;
				lap_3<=4'b0000;
				lap_4<=4'b0000;
				lap_5<=4'b0000;
			end
		else
			begin
				lap_0<=temp_value_0;
				lap_1<=temp_value_1;
				lap_2<=temp_value_2;
				lap_3<=temp_value_3;
				lap_4<=temp_value_4;
				lap_5<=temp_value_5;
			end
	
endmodule
